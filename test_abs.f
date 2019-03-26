      program test_abs
      integer :: i = -1
      real :: x = -1.e0
      complex :: z = (-1.e0,0.e0)
      write(*,*) 'i = ',i
      i = abs(i)
      write(*,*) 'abs i = ',i
      write(*,*) 'x = ',x
      x = abs(x)
      write(*,*) 'abs x = ',x
      write(*,*) 'z = ',z
      x = abs(z)
      write(*,*) 'abs z = ',x
      end program test_abs
