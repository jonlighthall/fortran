      program test_program
      implicit none
      interface
         integer function get_a_number()
         end function get_a_number
      end interface
      integer number
      write(*,'(a)') "hello, world"
      number=get_a_number()
      write(*,'(a,i2)') 'the number is ',number
      end program test_program

      integer function get_a_number()
      implicit none
      get_a_number = 42
      end function get_a_number
