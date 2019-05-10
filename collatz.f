      program collatz
      implicit none
      integer*16 n,i,seq,nmx
      common nmx
      call findmx
      write(*,*)'enter arbitrary positive integer'
      read *,n
      write(*,*)'received input ',n
      i=0
      do while (n.gt.1)
         write(*,*)'i = ',i,'ai = ',n
         n=seq(n)
         i=i+1
      enddo
      write(*,*)'i = ',i,'ai = ',n
      end

      integer*16 function seq(n)
      implicit none
      integer*16 n,nmx
      common nmx
      if (mod(n,2).eq.0) then
         seq=n/2
      else
         if(n.gt.nmx) then
            write(*,*)'ERROR: Overflow imminent.'
            write(*,*)'Maximum hailstone size exceeded',n,3*n+1
            seq=1
         else
            seq=3*n+1
         endif
      endif
      return
      end

      subroutine findmx
      implicit none
      integer*16 i,j,k,nmx
      common nmx
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
      write(*,*) '          the largest integer is', j
      nmx=(j-1)/3
      write(*,*) 'the largest hailstone integer is', nmx
      return
      end
