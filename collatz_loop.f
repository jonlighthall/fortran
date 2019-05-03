      program collatz_loop
      implicit none
      integer*16 n,seq,nmax

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
      
      n=j
      nmax=(j-1)/3

      write(*,*) '          the largest integer is', n
      write(*,*) 'the largest hailstone integer is', nmax

      n=nmax

      write(*,*)'received input ',n
      i=0
      do while (n.gt.1)
         write(*,*)'i = ',i,n
         n=seq(n,nmax)
         i=i+1
      enddo
      write(*,*)'i = ',i
      end

      integer*16 function seq(n,nmax)
      implicit none
      integer*16 n,seq,nmax
      if (mod(n,2).eq.0) then
         seq=n/2
      else
         if(n.gt.nmax) then
            write(*,*)'ERROR: Overflow imminent.'
            write(*,*)'Maximum hailstone size exceeded',n,3*n+1
            write(*,*)'   n = ',n
            write(*,*)'nmax = ',nmax
            write(*,*)'3n+1 = ',3*n+1
            seq=1
         else
            seq=3*n+1
         endif
      endif
      return
      end
