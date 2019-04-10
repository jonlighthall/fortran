      program pause
      print *, "hello world"
      print *, "fortan"
      do 10 i=0,2,1 !print beeps at end of program
         print *, " beep!", char(7)
         pause 
 10   continue
      end 
