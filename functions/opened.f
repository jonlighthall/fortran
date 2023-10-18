      integer function hello(unit)
      implicit none
      integer, intent(out), optional :: unit
      logical i_open
      write(*,'(a)') "hello world"
      hello=42
      inquire(unit=hello,opened=i_open)
      if (i_open) then
         write(*,*) 'opened'
      else
         write(*,*) 'closed'
      endif
      if (present(unit)) unit=hello
      end function hello
