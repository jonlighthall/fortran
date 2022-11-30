program bugs
  implicit none
  real last
  real c(10)
  integer p
  interface
     subroutine divide(d,e)
       real,intent(in) :: d,e
     end subroutine divide
  end interface

  !     Initialise c with successive integer values.
  do p=1,10
     c(p)=real(p)
  enddo

  !     Calculate and print ratios of successive integers.
  last = 0.0
  do p=1,10
     call divide(last, c(p))
     last = c(p)
  enddo
end program bugs

subroutine divide(d,e)
  implicit none
  real,intent(in) :: d,e
  print *,e/d
end subroutine divide
