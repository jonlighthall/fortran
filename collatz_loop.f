      program collatz_loop
      implicit none
      integer*16 nmax,steps,findnmax

      nmax=(findnmax()-1)/3
      write(*,*) 'the largest hailstone integer is', nmax

      write(*,*)'i = ',steps(nmax,nmax)
      end

      integer*16 function findnmax()
      implicit none
c     find maximum integer size without any a priori knowldege
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
      findnmax=j
      write(*,*) '          the largest integer is', j
      return
      end

      integer*16 function steps(n,nmax)
c     calculate number of steps
      implicit none
      integer*16 n,seq,nmax
c     write(*,*)'received input ',n
      steps=0
      do while (n.gt.1)
c     write(*,*)'steps = ',steps,n
         n=seq(n,nmax)
         steps=steps+1
      enddo
      return
      end

      integer*16 function seq(n,nmax)
c     calculate sequence
      implicit none
      integer*16 n,seq,nmax
      if (mod(n,2).eq.0) then
         seq=n/2
      else
         if(n.gt.nmax) then
            write(*,*)'ERROR: Overflow imminent.'
            write(*,*)'Maximum (odd) hailstone size exceeded',n,3*n+1
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
