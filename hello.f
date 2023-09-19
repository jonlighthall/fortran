      program hello
      implicit none
      integer i
      write(*,'(a)') "hello world"
      write(*,'(a)') "fortan"
      do i=1,3,1                !print beeps at end of program
         if(i.eq.1) then
            write(*,'(i2,2(a))')i," beep", char(7)
         else
            write(*,'(i2,2(a))')i," beeps", char(7)
         endif
         call sleep(1)
      enddo
      end
