program pi_monte_carlo
  implicit none
  double precision::x,y,error=1,pi_calculated
  integer::n=0,square=0,circle = 0
  double precision, parameter::pi=3.141592653589793d0
  do while (error>1e-10)
     call random_number(x)
     call random_number(y)
     if (sqrt(x**2.+y**2.)<=1.) then
        circle=circle+1
     end if
     square=square+1
     pi_calculated=4.*(dble(circle)/dble(square))
     error=abs(pi_calculated-pi)
     if(mod(n,int(1e6)).eq.0) &
          write(*,101)"steps=",n,"pi=",pi_calculated,"error= ",error
     n=n+1
  end do
  print *, "finished"
  write(*,101)"steps=",n,"pi=",pi_calculated,"error= ",error
101 format(a,i10,2x,2(a,f18.15,2x))
end program pi_monte_carlo
