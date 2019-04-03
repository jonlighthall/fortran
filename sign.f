      PROGRAM  SignControl
      IMPLICIT  NONE
      INTEGER   :: i
      REAL      :: x
      CHARACTER(LEN=*), PARAMETER :: Heading = "   SS   SP  SS    SP"
      WRITE(*,"(1X,A)") Heading
      DO i = -5, 5
         x = REAL(i)
         write(*,'(sp,2(i5),2(f6.1))')i,i,x,x
      END DO
      END PROGRAM  SignControl
