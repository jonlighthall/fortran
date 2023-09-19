      PROGRAM FUNDEM
      interface
         REAL FUNCTION AVRAGE(X,Y,Z)
         REAL X,Y,Z
         end function avrage
      end interface

C     Declarations for main program
      REAL A,B,C
      REAL AV, AVSQ1, AVSQ2
C     Enter the data
      PRINT *,'Three Number Averager'
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
C     Use WRITEs for debugging
d     WRITE(*,'(A,3(F5.2))') ' The inputs are:',X,Y,Z
      SUM = X + Y + Z
d     WRITE(*,200) ' The sum is:',SUM
d     200  FORMAT (A,F7.2)
      AVRAGE = SUM /3.0
      RETURN
      END
