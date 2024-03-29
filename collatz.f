      module set_fmt
      include 'set_format.f'
      end module

      program collatz
      use set_fmt,only:intsize
      implicit none
      integer(kind=intsize) n,i,sysmx,mxn,sd,seq
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
         if (mod(n,int(2,intsize)).eq.0) then
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
         n=seq
         if (n.gt.mxn) mxn=n
         i=i+1
      enddo
      write(*,*)'i = ',i,'ai = ',n
      write(*,*)'Mx(N) = ',mxn
      write(*,*)'for N = ',sd
      end program
