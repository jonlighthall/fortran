      program collatz
      implicit none
      include 'set_format.f'
      integer(kind=intsize) n,i,seq,sysmx,mxn,sd,gld
      logical gldfound
      common sysmx
      gldfound=.false.
      call findmx
      write(*,*)'enter arbitrary positive integer'
      read *,n
      write(*,*)'received input ',n
      sd=n
      i=0
      mxn=0
      gld=0
      do while (n.gt.1)
         write(*,*)'i = ',i,'ai = ',n
         n=seq(n)
         i=i+1
         if (n.gt.mxn) mxn=n
         if (n.lt.sd) then
            if (gldfound.eqv.. false.) then
               gld=i
               gldfound=.true.
            endif
         endif
      enddo
      write(*,*)'i = ',i,'ai = ',n
      write(*,*)'for N = ',sd
      write(*,*)'Mx(N) = ',mxn
      write(*,*)'G(N) = ',gld
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
      include 'set_format.f'
      integer(kind=intsize) i,j,k,sysmx
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
