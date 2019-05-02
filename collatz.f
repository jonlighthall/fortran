      program collatz
      do i=1,10
         write(*,*)'i = ',i,seq(i)
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
