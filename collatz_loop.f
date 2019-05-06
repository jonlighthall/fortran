      program collatz_loop
      implicit none
      integer*4 dly,dlymx,dlyrec,t1,t2,t
      integer*16 i,j,k,n,nmx,sd
      logical error
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
      error=.false.
      open(1,file = 'collatz.out')!,status='unknown',action='write')
      write(*,*) '          the largest integer is', j
      write(1,*) '          the largest integer is', j
      nmx=(j-1)/3
      write(*,*) 'the largest hailstone integer is', nmx
      write(1,*) 'the largest hailstone integer is', nmx
      write(*,*) 'record delay seed time'
      write(1,*) 'record delay seed time'
      dlymx=0                   ! delay max
      dlyrec=0                  ! delay record
      call system_clock(t1)
      do sd=0,nmx               ! seed range
         n=sd
         dly=0
         do while (n.gt.1)
            if (mod(n,2).eq.0) then
               n=n/2
            else
               if(n.gt.nmx) then
                  write(*,*)'ERROR ',n,dly,sd
                  write(1,*)'ERROR ',n,dly,sd
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
            write(*,*)dlyrec,dly,sd,t
            write(1,*)dlyrec,dly,sd
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
