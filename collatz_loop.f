      program collatz_loop
      implicit none
      integer dly,dlymx,dlyrec,t1,t2,t
      integer*8 i,j,k,n,nmx,sd,inmx,start
      logical error
      integer irec,idly,isd,iostat
      character(64) dum
c     read in existing file
      open(1,file = 'collatz.out',status='old',action='read',iostat
     &     =iostat)
      if (iostat.le.0) then
         read(1,'(34x,a)')dum   ! read line 1
         read(dum,*)inmx        ! convert to integer
         read(1,*) 
         read(1,*) 
         do 
            read(1,*,iostat=iostat)irec,idly,isd
            if (iostat.lt.0) exit
         enddo
         close(1)
      else
         inmx=0
         close(1)
      endif

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

c     test match      
      if(j.eq.inmx) then
         dlymx=idly             ! delay max
         dlyrec=irec            ! delay record
         start=isd+1
         write(*,*) '          the largest integer is', j
         nmx=(j-1)/3
         write(*,*) 'the largest hailstone integer is', nmx
         write(*,*)'starting from previous delay record '
         write(*,*) 'record delay seed time'
         write(*,*)irec,idly,isd
      else
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

      error=.false.
      call system_clock(t1)

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
                  write(*,*)'ERROR ',n,dly,sd
                  write(1,*)'ERROR ',n,dly,sd
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
      enddo
      close(1)
      end

c     bt | rec dly   seed
c     -- | --- --- ------
c      1 |   7  23     25
c      2 |  17 144    649
c      4 |  41 469 511935
c      8 |  
c     16 |  
