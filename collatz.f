      program collatz
      implicit none
      include 'set_format.f'
      integer(kind=intsize) n,i,sysmx,mxn,sd
      common sysmx
      sysmx=huge(i)
      write(*,*) '          the largest integer is', sysmx
      sysmx=(sysmx-1)/3
      write(*,*) 'the largest hailstone integer is', sysmx
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
      
      contains
      integer(kind=intsize)function seq(n)
      implicit none
      integer(kind=intsize) n,sysmx
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
      end function
      end program
