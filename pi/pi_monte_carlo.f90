program pi_monte_carlo
  implicit none
  integer,parameter :: knd=8
  real(kind=knd) :: x,y,error,pi_calculated
  integer::n,square,circle
  double precision, parameter::pi=3.141592653589793d0
  square=0
  circle=0
  error=real(1,knd)
  n=0
  do while (abs(error)>real(1e-10,knd))
     call random_number(x)
     call random_number(y)
     if (sqrt(x**real(2,knd)+y**real(2,knd))<=real(1,knd)) then
        circle=circle+1
     end if
     square=square+1
     pi_calculated=real(4,knd)*(real(circle,knd)/real(square,knd))
     error=(pi_calculated-pi)
     if(mod(n,int(1e5)).eq.0) &
          write(*,*)"steps=",n,"pi=",pi_calculated,"error=",error
     n=n+1
  end do
  print *, "finished"
  write(*,*)"steps=",n,"pi=",pi_calculated,"error=",error
end program pi_monte_carlo
