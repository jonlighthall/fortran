module version
  implicit none
  integer,parameter :: nspe_ver=42
!   character(len=5) :: text='world'
!   character(len=9), parameter :: dayname(7) = [character(len=9) :: 'Monday', 'Tuesday', &
!        'Wednesday', 'Thursday', 'Friday','Saturday', 'Sunday' ]
! contains
!   subroutine writedays()
!     write(*,*) dayname(1)
!   end subroutine writedays
  contains
    subroutine print_version()
      write(*,*) 'nspe version ',nspe_ver
    end subroutine print_version
    function inc(i)
        integer, intent(in) :: i
        integer :: inc
        inc = i + 1
        end function inc

end module version
