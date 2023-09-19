      PROGRAM subs
      interface
         subroutine f(N)
         integer N
         end subroutine
      subroutine f2(M,N)
      integer N,M
      end subroutine
      end interface
      integer i
      DO i = 2, 4
         CALL f(i)              !! Create array of size i
         CALL f2(i,i)           !! Create array of size ixi
      END DO
      END
