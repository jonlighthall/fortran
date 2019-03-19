      SUBROUTINE f(N)
      REAL, DIMENSION(N) :: A
      WRITE(*,'(A,I2)') 'Creating array of size',N
      DO i = 1, N
         A(i) = i
      END DO
      print *, A                !! Print an entire array
      END SUBROUTINE
