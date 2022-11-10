program rounding
  implicit none
  integer i,n,m,o,p
  integer, parameter :: mx = 100
  real a
  write(*,'(a)') "hello world"
  do i=0,mx
     a=real(i)/real(mx)
     n=amax1(0.,a) ! check value without adding 0.5
     m=amax1(0.,a+0.5) ! check value with 0.5
     o=max(0.,a+0.5) ! check equivalence of max
     p=max(0,nint(a)) ! formulate without warnings
     print '(i3,1x,f5.3,1x,5(i1,1x),l1)',i,a,int(a),n,m,o,p,(p.eq.m)
  enddo
end program rounding
