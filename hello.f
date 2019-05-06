      program hello
      write(*,'(a)') "hello world"
      write(*,'(a)') "fortan"
      do 10 i=1,3,1             !print beeps at end of program
         write(*,'(i2,3(a))')i+1,char(9),"beeps", char(7)
         call sleep(1)
 10   continue
      end 
