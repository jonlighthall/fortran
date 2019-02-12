      PROGRAM FUNDEM
C     Declarations for main program
      REAL A,B,C
      REAL AV, AVSQ1, AVSQ2
      REAL AVRAGE
C     Enter the data
      PRINT *,'Enter A'
      READ*, A 
      PRINT *,'Enter B'
      READ*, B 
      PRINT *,'Enter C'
      READ*, C
      
C     Calculate the average of the numbers
      AV = AVRAGE(A,B,C)
      AVSQ1 = AV**2
      AVSQ2 = AVRAGE(A**2,B**2,C**2)

      PRINT *,'Statistical Analysis'
      WRITE(*,100) '       The average of the numbers is: ',AV
 100  FORMAT (A,F5.2)
      WRITE(*,100)'  The average squared of the numbers: ',AVSQ1
      WRITE(*,100)'       The average of the squares is: ',AVSQ2
      END

      REAL FUNCTION AVRAGE(X,Y,Z)
      REAL X,Y,Z,SUM
      WRITE(*,'(A,F5.2,F5.2,F5.2)') ' The inputs are:',X,Y,Z
      SUM = X + Y + Z
      WRITE(*,100) ' The sum is:',SUM
 100  FORMAT (A,F5.2)
      AVRAGE = SUM /3.0
      RETURN
      END
