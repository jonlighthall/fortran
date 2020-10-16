      program test_program
      implicit none
      integer number,get_a_number
      write(*,'(a)') "hello world"
      number=get_a_number()
      write(*,*) 'the number is',number
      end program test_program


      integer function get_a_number()
      implicit none
      get_a_number = 42
      end function get_a_number
