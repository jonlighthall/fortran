program hello
  implicit none
#ifdef print_debug
  logical,parameter :: DEBUG=.true.
#else
  logical,parameter :: DEBUG=.false.
#endif
  print *, 'Hello, world!'
  if(DEBUG) print *,'goodbye'
end program hello
