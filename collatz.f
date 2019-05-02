      program collatz
      implicit none
      integer n,i,seq
      write(*,*)'enter arbitrary positive integer'
      read *,n
      write(*,*)'received input ',n
      i=0
      do while (n.gt.1)
         write(*,*)'i = ',i,n
         n=seq(n)
         i=i+1
      enddo
      write(*,*)'i = ',i,n
      end

      integer function seq(n)
      integer n
      if (mod(n,2).eq.0) then
         seq=n/2.
      else
         seq=3.*n+1.
      endif
      return
      end
