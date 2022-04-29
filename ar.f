      PROGRAM ar
      integer i
      DO i = 2, 4
         CALL f(i)              !! Create array of size i
         CALL f2(i,i)           !! Create array of size ixi
      END DO
      END

      SUBROUTINE f(N)
      integer N,i
      REAL, DIMENSION(N) :: A
      WRITE(*,'(A,I2)') 'Creating array of size',N
      DO i = 1, N
         A(i) = i
      END DO
      print *, A                !! Print an entire array
      END SUBROUTINE

      SUBROUTINE f2(M,N)
      integer N,M,i,j
      REAL, DIMENSION(N,M) :: A
      WRITE(*,'(A,I2,A,I2)') 'Creating array of size',N,' x ',M
      DO i = 1, M
         DO j = 1, N
            A(i,j) = i
         END DO
      END DO
      DO i = 1, M
         write(*,'(100f5.2)') ( A(i,j), j=1,n )
      END DO
      END SUBROUTINE
