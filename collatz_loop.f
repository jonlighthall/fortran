      program collatz_loop
      implicit none
      integer dly,dlymx,dlyrec,t1,t2,t
      integer*16 i,j,k,n,sysmx,sd,isysmx,start,isd
      logical error, interrupt
      common interrupt
      integer irec,idly,iostat,ln,ilen
      character(128) dum,fmt
      intrinsic signal
      external handler
c     find maximum integer
      i=1 
      j=0
      do while (i.gt.j)
         j=i
         i=i*2
      enddo
      do k=floor(log10(real(j))),0,-1
         i=j
         j=i-1
         do while (i.gt.j)
            j=i
            i=i+10**k
         enddo
      enddo
      k=ceiling(log10(real(j)))
      write(fmt,*)'(a,i',k,')'

c     read in existing file
      open(1,file = 'collatz.out',status='old',action='read',iostat
     &     =iostat)
      open(2,status='scratch')
      if (iostat.le.0) then
         read(1,'(33x,a)')dum   ! read line 1
         dum=adjustl(dum)
c     check if input max exceeds sys max w/o invoking overflow
         ilen=len(trim(dum))
         if (ilen.gt.k) then
            write(*,'(3a,i3)')'  length of file maximim ',trim(dum)
     &           ,' is ',ilen
            write(*,fmt)'length of system maximum ',k
            write(*,'(a,i3,a,i3)')'ERROR: Overflow imminent. ',ilen
     &           ,' > ',k
            isysmx=0
            start=1
            close(1)
         else
         read(dum,*)isysmx        ! convert to integer
         rewind(1)
         if(isysmx.lt.j)then
            write(*,fmt) '  file maximim ',isysmx
            write(*,fmt) 'system maximum ',j
            read(1,'(a)') dum
            write(2,fmt) '          the largest integer is ', j
            sysmx=(j-1)/3
            read(1,'(a)') dum
            write(2,fmt) 'the largest hailstone integer is ', sysmx
            read(1,'(a)') dum
            write(2,'(a)')trim(dum)
            isysmx=j
         else
            write(*,*)'file and system maxima match'
            do i=1,3
            read(1,'(a)') dum
            write(2,'(a)')trim(dum)
         enddo
         endif
         ln=3
         do 
            read(1,*,iostat=iostat)irec,idly,isd
            ln=ln+1
            if (irec.eq.-1) then
               start=isd
               rewind(1)
               do i=1,ln-2,1
                  read(1,*)
               enddo
               read(1,*)irec,idly,isd
               exit
            else
               write(2,*)irec,idly,isd
            endif
            start=isd+1
            if (iostat.lt.0) exit
         enddo
         close(1)
         rewind(2)
         open(1,file = 'collatz.out',status='old',action='write')
         do i=1,3
            read(2,'(a)') dum
            write(1,'(a)')trim(dum)
            write(*,'(a)')trim(dum)
         enddo
         do i=4,ln-1
            read(2,*) irec,idly,isd
            write(*,*)irec,idly,isd
            write(1,*)irec,idly,isd
         enddo
         close(1)
         endif
      else
         isysmx=0
         start=1
         close(1)
      endif
      close(2)

c     test match      
      if(j.eq.isysmx) then
         dlymx=idly             ! delay max
         dlyrec=irec            ! delay record
         sysmx=(j-1)/3
         write(*,*) 'record delay seed time'
         write(*,*)-1,-1,start,0
      else
         write(*,*)'starting over...'
         open(1,file = 'collatz.out',status='unknown',action='write')
         write(*,fmt) '          the largest integer is ', j
         write(1,fmt) '          the largest integer is ', j
         sysmx=(j-1)/3
         write(*,fmt) 'the largest hailstone integer is ', sysmx
         write(1,fmt) 'the largest hailstone integer is ', sysmx
         write(*,*) 'record delay seed time'
         write(1,*) 'record delay seed'
         close(1)
         start=0
         dlymx=0          
         dlyrec=0         
      endif

c     initialize controls
      error=.false.
      call system_clock(t1)
      call signal (2,handler)   ! interrupt
      call signal (3,handler)   ! quit
      interrupt = .false.

c     loop over all possible numbers      
      do sd=start,sysmx           ! seed range
         n=sd
         dly=0
         do while (n.gt.1)
            if (mod(n,2).eq.0) then
               n=n/2
            else
               if(n.gt.sysmx) then
                  open(1,file = 'collatz.out',status="old", position 
     &                 ="append",action="write") 
                  write(*,*)-1,dly,sd,'ERROR ',n,'Overflow imminent.'
                  write(1,*)-1,dly,sd,'ERROR ',n
                  close(1)
                  n=1           ! exit loop
                  error=.true.
               else
                  n=3*n+1
               endif
            endif
            dly=dly+1         
         enddo
c     increment and save delay record
         if (dly>dlymx) then
            dlyrec=dlyrec+1
            call system_clock(t2)
            t=t2-t1
            open(1,file = 'collatz.out',status="old", position="append",
     &           action="write") ! force write at each iteration
            write(*,*)dlyrec,dly,sd,t
            write(1,*)dlyrec,dly,sd
            close(1)
            dlymx=dly
            call system_clock(t1)
         endif
c     check exit flags
         if (error) exit
         if (interrupt) then
            print*,'Saving current position...'
            open(1,file = 'collatz.out',status='old',action='write'
     &           ,position="append")
            write(1,*)-1,dly,sd
            close(1)
            write(*,*)dly,sd
            exit
         endif
      enddo
c     print summary
      write(*,*)'exited loop'
      write(*,*)'found',dlyrec,'delay records'
      write(*,*)'max delay is ',dlymx
      write(*,*)'last calculation',dly,sd
      end

c     bt | rec dly   seed
c     -- | --- --- ------
c      1 |   7  23     25
c      2 |  17 144    649
c      4 |  41 469 511935
c      8 |  
c     16 |  

      function handler()
      logical interrupt
      common interrupt
      interrupt = .true.
      print*,'Ctrl+C pressed',interrupt
      end function handler
