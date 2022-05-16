      program gethost
      character*32 hostname
      call get_environment_variable('HOST',hostname)
      write(*,*) 'My gracious host is ',trim(hostname)
      write(*,*) 'hostname length = ',len(trim(adjustl(hostname)))
      call get_environment_variable('HOSTNAME',hostname)
      write(*,*) 'My gracious host is ',trim(hostname)
      write(*,*) 'hostname length = ',len(trim(adjustl(hostname)))
      end program gethost
