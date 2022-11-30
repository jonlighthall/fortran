program pi_monte_carlo
  implicit none
  integer, parameter :: dp = 10
  integer,parameter :: srk = selected_real_kind(dp)
  real(kind=srk) :: x,y,error,pi_calculated,thresh
  integer::n=0,square=0,circle = 0
  real(kind=srk), parameter :: pi=3.141592653589793d0
  real(kind=srk), parameter :: one=1,two=2,four=4
  character(len=32) :: fmt1,fmt2
  write(*,'(1x,i2,a,i2,a)')dp,' decimals reqested (using ',srk,' bytes)'
  thresh=real(10.**(-dp),srk)
  error=thresh+1
  write(fmt1,'("(a,f",i0,".",i0,")")')dp+2,dp
  print fmt1,'             pi = ',pi
  print fmt1,'error threshold = ',thresh
  write(fmt2,'("(a,i10,2x,2(a,f",i0,".",i0,",2x))")')dp+2,dp
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
          write(*,fmt2)"steps=",n,"pi=",pi_calculated,"error= ",error
       endif
     n=n+1
  enddo
  write(*,fmt2)"steps=",n,"pi=",pi_calculated,"error= ",error
end program pi_monte_carlo
