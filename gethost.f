      program gethost
      implicit none
      character(len=256) hostname
      integer length, status
      logical trim
      call get_environment_variable("HOST",hostname,length,status)
      if (length.eq.0) then
         call get_environment_variable("HOSTNAME",hostname,length
     &        ,status)
         if (length.eq.0) then
            CALL getenv("HOST", hostname)
            if (len(trim(adjustl(hostname))).eq.0) then
               CALL getenv("HOSTNAME", hostname)
               if (len(trim(adjustl(hostname))).eq.0) then
                  call hostnm(hostname);
               endif
            endif
         endif
      endif
      WRITE (*,*) "host name: ",TRIM(hostname)
      end program gethost
