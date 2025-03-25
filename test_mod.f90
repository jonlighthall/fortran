program hello
  use version
  implicit none
  write(*,'(a)') "hello world"
  write(*,'(a)') "fortan"
  write(*,*) nspe_ver
  call print_version
  print*,inc(1)
end program hello
