      program hello
      write(*,'(a)') "hello world"
      write(*,'(a)') "fortan"
      do 10 i=1,3,1             !print beeps at end of program
         write(*,'(i2,2(a))')i," beeps", char(7)
         call sleep(1)
 10   continue
      end 
