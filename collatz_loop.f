      program collatz_loop
      implicit none
      integer dly,dlymx,dlyrec,t0,t1,t2,t
      include 'set_format.f'
      integer(kind=intsize) i,j,k,n,sysmx,sd,isysmx,start,isd,dif,last
      character(len=fmtsize) fmt_str
      logical error, interrupt
      common interrupt
      integer irec,idly,iostat,ln,ilen
      character(len=128) dum,fmt
      intrinsic signal
      external handler
      integer,dimension(8) :: values
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
      open(1,file = 'collatz.txt',status='old',action='read',iostat
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
         open(1,file = 'collatz.txt',status='old',action='write')
         do i=1,3
            read(2,'(a)') dum
            write(1,'(a)')trim(dum)
            write(*,'(a)')trim(dum)
         enddo
         do i=4,ln-1
            read(2,*) irec,idly,isd
            write(dum,*)isd
            call format(isd,fmt_str)
            write(*,'(i4,1x,i4,1x,a,2(i4))')irec,idly
     &           ,trim(adjustl(fmt_str))
            write(1,'(i4,1x,i4,1x,a)')irec,idly,trim(adjustl(dum))
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
         write(*,*)'continuing...'
         write(*,'(a,t30,a)') ' rec  dly seed','     time date'
         call format(start,fmt_str) 
         call date_and_time(VALUES=values)
         write(*,'(i4,1x,i4,1x,a,1x,t30,i9,1x,i0.2,a,i0.2,a,i4,1x
     &        ,i0.2,a,i0.2,a,i0.2,a,i0.3,a,sp,i0.2,a)')-1,-1
     &        ,trim(adjustl(fmt_str)),0,values(2),'/',values(3),'/'
     &        ,values(1),values(5),':',values(6),':',values(7),'.'
     &        ,values(8),' ',values(4)/60,' UTC'
      else
         write(*,*)'starting over...'
         open(1,file = 'collatz.txt',status='unknown',action='write')
         write(*,fmt) '          the largest integer is ', j
         write(1,fmt) '          the largest integer is ', j
         sysmx=(j-1)/3
         write(*,fmt) 'the largest hailstone integer is ', sysmx
         write(1,fmt) 'the largest hailstone integer is ', sysmx
         write(*,'(a,t30,a)') ' rec  dly seed','     time date'
         write(1,'(a)') ' rec  dly seed'
         close(1)
         start=0
         dlymx=0          
         dlyrec=0         
      endif
      write(*,*)'press Ctrl-C to safely interrupt'

c     initialize controls
      error=.false.
      call system_clock(t0)
      call system_clock(t1)
      call signal (1,handler)   ! hang up
      call signal (2,handler)   ! interrupt
      call signal (3,handler)   ! quit
      call signal (4,handler)   ! illegal
      call signal (5,handler)   ! trap
      call signal (6,handler)   ! abort
      call signal (7,handler)   ! busy
      call signal (8,handler)   ! floating point error
      call signal (15,handler)  ! terminate
      interrupt = .false.
      last=start

c     loop over all possible numbers      
      do sd=start,sysmx           ! seed range
         n=sd
         dly=0
         do while (n.gt.1)
            if (mod(n,int(2,intsize)).eq.0) then
               n=n/2
            else
               if(n.gt.sysmx) then
                  open(1,file = 'collatz.txt',status="old", position 
     &                 ="append",action="write") 
                  write(dum,*)sd
                  call format(sd,fmt_str)
                  write(*,'(i4,1x,i4,1x,2a)')-1,dly
     &                 ,trim(adjustl(fmt_str))
     &                 ,' ERROR Overflow imminent.'
                  write(1,'(i4,1x,i4,1x,2a)')-1,dly,trim(adjustl(dum)
     &                 ),' ERROR Overflow imminent.'
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
            last=sd
            call system_clock(t2)
            t=t2-t1
            call date_and_time(VALUES=values)
            open(1,file = 'collatz.txt',status="old", position="append",
     &           action="write") ! force write at each iteration
            write(dum,*)sd
            call format(sd,fmt_str)
            write(*,'(i4,1x,i4,1x,a,1x,t30,i9,1x,i0.2,a,i0.2,a,i4,1x,i0.
     &           2,a,i0.2,a,i0.2,a,i0.3,a,sp,i0.2,a)')dlyrec,dly
     &           ,trim(adjustl(fmt_str)),t,values(2),'/',values(3),'/'
     &           ,values(1),values(5),':',values(6),':',values(7),'.'
     &           ,values(8),' ',values(4)/60,' UTC'
            write(1,'(i4,1x,i4,1x,a)')dlyrec,dly,trim(adjustl(dum))
            close(1)
            dlymx=dly
            call system_clock(t1)
         endif
c     check exit flags
         if (error) exit
         if (interrupt) then
            print*,'Saving current position...'
            call system_clock(t2)
            t=t2-t1
            open(1,file = 'collatz.txt',status='old',action='write'
     &           ,position="append")
            write(dum,*)sd
            write(1,'(i4,1x,i4,1x,a)')-1,dly,trim(adjustl(dum))
            close(1)
            call format(sd,fmt_str)
            write(*,'(i4,1x,i4,1x,a,1x,t30,i9)')-1,dly
     &           ,trim(adjustl(fmt_str)),t
            exit
         endif
      enddo
c     print summary
      write(*,*)'exited loop'
      dif=sd-start
      t=t2-t0
      write(dum,*)real(dif)/t
      write(*,*)'time = ',t
      write(*,*)'processing rate ',trim(adjustl(dum)),' seeds per sec'
      write(*,*)'estimate ',real(sysmx-sd)/real(dif*t)
      write(*,'(a,i3,a)')' found ',dlyrec,' delay records'
      write(*,'(a,i4)')' max delay is ',dlymx
      write(*,*)'start = ',start
      write(*,*)' last = ',last
      write(*,*)'   sd = ',sd
      dif=sd-last
      write(*,*)' diff = ',dif
      call format(dif,fmt_str)
      write(*,*)' it has been ',trim(adjustl(fmt_str))
     &     ,' since a record has been found'
      end

c     largest sequential delay without overflow error
c
c     bt | rec  dly    seed
c     -- | ---  --- ----------
c      1 |   5   19          9
c      2 |  16  143        327
c      4 |  35  353     106239
c      8 |  71 1131 8528817511
c     16 |  

      subroutine handler()
      logical interrupt
      common interrupt
      interrupt = .true.
      print*,'Ctrl-C pressed',interrupt
      end subroutine handler
