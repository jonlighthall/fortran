      program collatz_loop
      implicit none
      integer*2 i,j,k,n,nmx,dly,dlymx,dlyrec,sd
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
      write(*,*) '          the largest integer is', j
      nmx=(j-1)/3
      write(*,*) 'the largest hailstone integer is', nmx
      dlymx=0                   ! delay max
      dlyrec=0                  ! delay record
      do sd=0,nmx               ! seed range
         n=sd
         dly=0
         do while (n.gt.1)
            if (mod(n,2).eq.0) then
               n=n/2
            else
               if(n.gt.nmx) then
                  write(*,*)'ERROR ',n,dly,sd
                  n=1           ! exit loop
               else
                  n=3*n+1
               endif
            endif
            dly=dly+1         
         enddo
         if (dly>dlymx) then
            dlyrec=dlyrec+1  
            write(*,*)'mx = ',dlyrec,dly,sd
            dlymx=dly
         endif
      enddo
      end
