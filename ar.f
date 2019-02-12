      SUBROUTINE f(N)
      IMPLICIT NONE
      INTEGER N
      REAL, DIMENSION(N) :: A	!! You can define arrays using
                                !! VARIABLES in Fortran 90.... like Ada    
      INTEGER i
      DO i = 1, N
         A(i) = i
      END DO
      print *, A                !! Print an entire array
      END SUBROUTINE

      PROGRAM main
      IMPLICIT NONE
      INTEGER i
      DO i = 2, 4
         CALL f(i)              !! Create array of size i
         CALL f2(i,i)           !! Create array of size ixi
      END DO
      END

      SUBROUTINE f2(N,M)
      IMPLICIT NONE
      INTEGER N, M
      REAL, DIMENSION(N,M) :: A	
      INTEGER i,j
      DO i = 1, N
         DO j = 1, N
            A(i,j) = i
         END DO
      END DO
      print *, A                !! Print an entire array
      END SUBROUTINE
      
