      program pause
      integer i
      character(len=2) words
      print *, "hello world"
      print *, "fortan"
      do 10 i=1,3
         write(*,'(i2,a,a)')i,' beeps!'
     &        ,char(7)          ! print beeps at end of program
      pause 'pause'
         write(*,'(a)') 'PAUSE'
         write(*,'(a)',advance="no") 'To resume execution, type go.  '
         write(*,'(a)') 'Other input will terminate the job.'
         print *, 'pause (press enter to continue)'
         read(*,'(a)')words
         if(words=='go') then
            print *,'yes, go'
            print '(a)','RESUMED'
         else
            print *,'no go'
            exit
         endif
 10   continue
      end
