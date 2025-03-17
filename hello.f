      program hello
      implicit none
      integer i
      write(*,'(a)') "hello world"
      write(*,'(a)') "fortan"
      do i=1,3,1                !print beeps at end of program
         if(i.eq.1) then
            write(*,'(i2,3(a))',advance='no')i," beep", char(13),
     >           char(7)
         else
            write(*,'(i2,3(a))',advance='no')i," beeps", char(13),
     >           char(7)
         endif
         call sleep(1)
      enddo
      end
