      SUBROUTINE f2(M,N)
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
