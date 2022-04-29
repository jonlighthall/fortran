      program pause
      integer i
      print *, "hello world"
      print *, "fortan"
      do 10 i=1,3
         write(*,'(i2,a,a)')i,' beeps!'
     &        ,char(7)          ! print beeps at end of program
         pause 'pause'
 10   continue
      end 
