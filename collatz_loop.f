      program collatz_loop
      implicit none
      integer dly,dlymx,dlyrec,t1,t2,t
      integer*8 i,j,k,n,nmx,sd,inmx,start
      logical error, interrupt
      common interrupt
      integer irec,idly,isd,iostat,ln,ilen
      character(64) dum
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

c     read in existing file
      open(1,file = 'collatz.out',status='old',action='read',iostat
     &     =iostat)
      open(2,status='scratch')
      if (iostat.le.0) then
         read(1,'(33x,a)')dum   ! read line 1
         dum=adjustl(dum)
c     check if input max exceeds sys max w/o invoking overflow
         ilen=len(trim(dum))
         k=ceiling(log10(real(j)))
         if (ilen.gt.k) then
            write(*,*)'length of file maximim ',trim(dum),ilen
            write(*,*)'length of system maximum ',k
            write(*,*)'ERROR: Overflow imminent.',ilen,k
            inmx=0
            start=1
            close(1)
         else
         read(dum,*)inmx        ! convert to integer
         rewind(1)
         if(inmx.lt.j)then
            write(*,*)'file maximim ',inmx
            write(*,*)'system maximum ',j
            read(1,'(a)') dum
            write(2,*) '          the largest integer is', j
            nmx=(j-1)/3
            read(1,'(a)') dum
            write(2,*) 'the largest hailstone integer is', nmx
            read(1,'(a)') dum
            write(2,'(a)')dum
            inmx=j
         else
         do i=1,3
            read(1,'(a)') dum
            write(2,'(a)')dum
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
            write(1,'(a)')dum
            write(*,'(a)')dum
         enddo
         do i=4,ln-1
            read(2,*) irec,idly,isd
            write(*,*)irec,idly,isd
            write(1,*)irec,idly,isd
         enddo
         close(1)
         endif
      else
         inmx=0
         start=1
         close(1)
      endif
      close(2)

c     test match      
      if(j.eq.inmx) then
         dlymx=idly             ! delay max
         dlyrec=irec            ! delay record
         nmx=(j-1)/3
         write(*,*) 'record delay seed time'
         write(*,*)-1,-1,start,0
      else
         write(*,*)'starting over...'
         open(1,file = 'collatz.out',status='unknown',action='write')
         write(*,*) '          the largest integer is', j
         write(1,*) '          the largest integer is', j
         nmx=(j-1)/3
         write(*,*) 'the largest hailstone integer is', nmx
         write(1,*) 'the largest hailstone integer is', nmx
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
      do sd=start,nmx           ! seed range
         n=sd
         dly=0
         do while (n.gt.1)
            if (mod(n,2).eq.0) then
               n=n/2
            else
               if(n.gt.nmx) then
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
