program rounding
  implicit none
  integer i,n,m,o,p,q,ni,mi,oi
  integer, parameter :: mx = 100
  real a
  write(*,'(a)') "hello world"
  do i=47,mx
    ! define fraction
     a=real(i)/real(mx)

     
     n=a ! check value without adding 0.5
     m=a+0.49 ! check value with 0.49
     o=a+0.5 ! check value with 0.5
     ni=int(a) ! check value without adding 0.5
     mi=int(a+0.49) ! check value with 0.5
     oi=int(a+0.5) ! check equivalence of max
     p=nint(a) !
     q=ifix(a) !
     print '(i3,1x,f5.3,1x,8(i1,1x),l1)',i,a,n,m,o,ni,mi,oi,p,q,(p.eq.m)
  enddo
end program rounding
