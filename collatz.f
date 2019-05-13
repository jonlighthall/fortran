      program collatz
      implicit none
      integer*16 n,i,seq,sysmx,mxn,sd
      common sysmx
      call findmx
      write(*,*)'enter arbitrary positive integer'
      read *,n
      write(*,*)'received input ',n
      sd=n
      i=0
      mxn=0
      do while (n.gt.1)
         write(*,*)'i = ',i,'ai = ',n
         n=seq(n)
         if (n.gt.mxn) mxn=n
         i=i+1
      enddo
      write(*,*)'i = ',i,'ai = ',n
      write(*,*)'Mx(N) = ',mxn
      write(*,*)'for N = ',sd
      end

      integer*16 function seq(n)
      implicit none
      integer*16 n,sysmx
      common sysmx
      if (mod(n,2).eq.0) then
         seq=n/2
      else
         if(n.gt.sysmx) then
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
      integer*16 i,j,k,sysmx
      common sysmx
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
      sysmx=(j-1)/3
      write(*,*) 'the largest hailstone integer is', sysmx
      return
      end
