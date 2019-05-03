      program collatz_loop
      implicit none
      integer*16 n,nmax,iter,maxstep,nstep
      integer*16 i, j, k
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
      n=nmax
      maxstep=0
      nstep=0
      do iter=0,1000000
         n=iter
c         write(*,*)'received input ',n
         i=0
         do while (n.gt.1)
c            write(*,*)'i = ',i,n
            if (mod(n,2).eq.0) then
               n=n/2
            else
               if(n.gt.nmax) then
                  write(*,*)'ERROR: Overflow imminent.'
                  write(*,*)'Maximum hailstone size exceeded',n,3*n+1
                  write(*,*)'   n = ',n
                  write(*,*)'nmax = ',nmax
                  write(*,*)'3n+1 = ',3*n+1
                  n=1
               else
                  n=3*n+1
               endif
            endif
            i=i+1
         enddo
         if (i>maxstep) then
            nstep=nstep+1
            write(*,*)'i = ',nstep,i,iter
            maxstep=i
         endif
      enddo
      end
