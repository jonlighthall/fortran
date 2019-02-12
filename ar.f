SUBROUTINE f(N)
   IMPLICIT NONE

   INTEGER N

   REAL, DIMENSION(N) :: A	!! You can define arrays using
                                !! VARIABLES in Fortran 90.... like Ada    

   INTEGER i

   DO i = 1, N
      A(i) = i
   END DO

   print *, A			!! Print an entire array

  END SUBROUTINE

  PROGRAM main
   IMPLICIT NONE

   CALL f(2)			!! Create array of size 2

   CALL f(3)			!! Create array of size 3
  END
