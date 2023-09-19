program pi_monte_carlo
  implicit none
  integer, parameter :: dp = 10
  integer,parameter :: srk = selected_real_kind(dp)
  real(kind=srk) :: x,y,error,pi_calculated,thresh
  integer::n=0,square=0,circle = 0,pdp=0,last=0
  real(kind=srk), parameter :: pi=3.141592653589793d0
  real(kind=srk), parameter :: one=1,two=2,four=4,ten=10
  character(len=32) :: fmt1,fmt3,val,fmt4
  write(*,'(1x,i2,a,i2,a)')dp,' decimals reqested'
  write(*,'(1x,i2,a,i2,a)')precision(pi_calculated),' decimals available (using ',srk,' bytes)'
  thresh=ten**(-dp)
  error=thresh+1
  write(fmt1,'("(a,f",i0,".",i0,")")')dp+2,dp
  print fmt1,'             pi = ',pi
  print fmt1,'error threshold = ',thresh
  do while (error>thresh)
     call random_number(x)
     call random_number(y)
     if (sqrt(x**two+y**two)<=one) then
        circle=circle+1
     end if
     square=square+1
     pi_calculated=four*(real(circle,srk)/real(square,srk))
     error=abs(pi_calculated-pi)
     pdp=(-ceiling(log10(error)))
     if(pdp.gt.last) then
        last=pdp
        write(fmt3,'("(i2,a,i10,2x,a,a",i0,",2x,a,f",i0,".",i0,")")')dp+2,dp+2,pdp
        write(fmt4,'("(f",i0,".",i0,")")')pdp+2-1,pdp-1
        write(val,fmt4)pi_calculated
        write(*,fmt3)pdp,": steps=",n,"pi= ",val,"error= ",error
       endif
     n=n+1
  enddo
end program pi_monte_carlo
