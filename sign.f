      PROGRAM  sign
      WRITE(*,"(1X,A)") "   SS   SP  SS    SP"
      DO i = -5, 5
         x = REAL(i)
         write(*,'(sp,2(i5),2(f6.1))')i,i,x,x
      END DO
      END 
