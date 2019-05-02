      program collatz
      integer n
      write(*,*)'enter arbitrary positive integer'
      read *,n
      write(*,*)'received input ',n
      bak=n
      do i=1,10
         write(*,*)'i = ',i,n
         n=seq(n)

      enddo
      end

      real function seq(n)
      integer n
         if (mod(n,2).eq.0) then
            write(*,*)'even'
            seq=n/2.
         else
            write(*,*)'odd'
            seq=3.*n+1.
      endif
      return
      end
