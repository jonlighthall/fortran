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
      PRINT *,'The average of the numbers is:',AV
      PRINT *,'The average squared of the numbers:',AVSQ1
      PRINT *,'The average of the squares is:',AVSQ2
      END

      REAL FUNCTION AVRAGE(X,Y,Z)
      REAL X,Y,Z,SUM
      PRINT *,'The inputs are:',X,Y,Z
      SUM = X + Y + Z
      PRINT *, 'The sum is:',SUM
      AVRAGE = SUM /3.0
      RETURN
      END
