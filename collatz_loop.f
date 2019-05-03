      program collatz_loop
      implicit none
      integer*1 i,j,k,n,nmax,maxstep,nstep
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
      nmax=(j-1)/3
      write(*,*) 'the largest hailstone integer is', nmax
      maxstep=0
      nstep=0
      do j=0,nmax
         write(*,*)'seed = ',j
         n=j
         i=0
         do while (n.gt.1)
            write(*,*)'step = ',i,n
            if (mod(n,2).eq.0) then
               n=n/2
            else
               if(n.gt.nmax) then
                  write(*,*)'ERROR: Overflow imminent.'
                  write(*,*)'Maximum hailstone size exceeded'
                  write(*,*)'seed = ',j
                  write(*,*)'   n = ',n
                  write(*,*)'nmax = ',nmax
                  write(*,*)'3n+1 = ',3*n+1
                  k=3*n+1
                  write(*,*)'   k = ',k
                  n=1
               else
                  n=3*n+1
               endif
            endif
            i=i+1
         enddo
         if (i>maxstep) then
            nstep=nstep+1
            write(*,*)'max = ',nstep,i,j
            maxstep=i
         endif
      enddo
      end
