program compare
  implicit none
  integer :: i=1,j,k
  real :: a=1.5
  print*,'i = ',i
  print*,'a = ',a
  if (abs(a-real(i,kind(a))).lt.epsilon(a)) then
     print*,"equal"
  else
     print*,"not equal"
  endif

  j=int(a)
  print*,'j = ',j
  if (i.eq.j) then
     print*,"equal"
  else
     print*,"not equal"
  endif

  k=nint(a)
  print*,'k = ',k
  if (i.eq.k) then
     print*,"equal"
  else
     print*,"not equal"
  endif
end program compare
