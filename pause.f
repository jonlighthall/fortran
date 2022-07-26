      program pause
      integer i
      character(len=2) words
      print *, "hello world"
      print *, "fortan"
      do 10 i=1,3
         write(*,'(i2,a,a)')i,' beeps!'
     &        ,char(7)          ! print beeps at end of program
! approximate PAUSE replacement; does not check past 2 characters
         write(*,'(a)') 'PAUSE'
         write(*,'(a)',advance="no") 'To resume execution, type go.  '
         write(*,'(a)') 'Other input will terminate the job.'
         read(*,'(a)')words
         if(words=='go') then
            print '(a)','RESUMED'
         else
            exit
         endif
 10   continue
      end
