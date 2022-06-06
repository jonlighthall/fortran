      program gethost
      character(len=256) hostname
      integer length, status
      logical trim
      call get_environment_variable("HOST",hostname,length,status)
      write(*,*) 'My gracious host is ',trim(hostname),length,status
      write(*,*) 'hostname length = ',len(trim(adjustl(hostname)))
      call get_environment_variable("HOSTNAME",hostname,length,status)
      write(*,*) 'My gracious host is ',trim(hostname),length,status
      write(*,*) 'hostname length = ',len(trim(adjustl(hostname)))
     &     ,length,status

      CALL getenv("HOME", hostname)
      WRITE (*,*) TRIM(hostname)

      CALL getenv("HOST", hostname)
      WRITE (*,*) TRIM(hostname)

      CALL getenv("HOSTNAME", hostname)
      WRITE (*,*) TRIM(hostname)

      call hostnm(hostname);
      write(*,*) hostname

      end program gethost
