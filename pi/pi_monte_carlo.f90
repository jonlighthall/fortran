program pi_monte_carlo
  implicit none
  double precision::x,y,error,pi_calculated
  integer::n,square,circle
  double precision, parameter::pi=3.141592653589793d0
  square=0
  circle=0
  error=1.
  n=0
  do while (abs(error)>1e-10)
     x=ran()
     y=ran()
     !   call random_number(x)
     !   call random_number(y)
     if (sqrt(x**2.+y**2.)<=1.) then
        circle=circle+1
        square=square+1
     else
        square=square+1
     end if
     pi_calculated=4.*(dble(circle)/dble(square))
     error=(pi_calculated-pi)
     if(mod(n,int(1e5)).eq.0) write(*,*)"steps=",n,"pi=",pi_calculated,"error=",error
     n=n+1
  end do
  print *, "finished"
  write(*,*)"steps=",n,"pi=",pi_calculated,"error=",error
  end program 
