program pi_monte_carlo
  implicit none
  integer, parameter :: dp = 4
  integer,parameter :: srk = selected_real_kind(dp)
  real(kind=srk) :: x,y,error,pi_calculated,thresh
  integer::n=0,square=0,circle = 0
  real(kind=srk), parameter :: pi=3.141592653589793
  real(kind=srk), parameter :: one=1,two=2,four=4

  write(*,'(1x,i2,a,i2,a)')dp,' decimals reqested (using ',srk,' bytes)'
  thresh=real(10.**(-dp),srk)
  error=thresh+1
  print*,'error threshold = ',thresh
  do while (error>thresh)
     call random_number(x)
     call random_number(y)
     if (sqrt(x**two+y**two)<=one) then
        circle=circle+1
     end if
     square=square+1
     pi_calculated=four*(real(circle,srk)/real(square,srk))
     error=abs(pi_calculated-pi)
     if(mod(n,int(1e6)).eq.0) then 
          write(*,101)"steps=",n,"pi=",pi_calculated,"error= ",error
       endif
     n=n+1
  enddo
  print *, "finished"
  write(*,101)"steps=",n,"pi=",pi_calculated,"error= ",error
101 format(a,i10,2x,2(a,f18.15,2x))
end program pi_monte_carlo
