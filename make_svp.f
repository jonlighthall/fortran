      program make_svp
      INTEGER :: count
      CALL SYSTEM_CLOCK(count)
      call srand(count)

      open(1,file = 'svp.in',status='unknown',action='write')
      write(1,*)'svp'
      do i=1,3    
         write(*,*)(i-1)*250,rand(),rand(),rand()
         write(1,*)(i-1)*250
         do j=1,10
            write(*,*) j,(j-1)*2.5,(rand()-0.5)*20+1500,(rand()-0.5)*20
            write(1,*) j,(j-1)*2.5,(rand()-0.5)*20+1500,(rand()-0.5)*20
         enddo
         write(*,*)repeat(' -1 ',4)
         write(1,*)repeat(' -1 ',4)
      enddo
      close(1)
      end
