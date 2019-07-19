      program make_svp
      integer :: count
      call system_clock(count)  ! get system time in milliseconds
      call srand(count)         ! use time for random seed

      open(1,file = 'svp.in',status='unknown',action='write')
      write(1,*)'svp'
      do i=1,3    
         write(*,*)(i-1)*250,rand(),rand(),rand()
         write(1,*)(i-1)*250
         do j=1,10
c     NOTE: screen print and file contents will not match
            write(*,*) j,(j-1)*2.5,(rand()-0.5)*20+1500,(rand()-0.5)*20
            write(1,*) j,(j-1)*2.5,(rand()-0.5)*20+1500,(rand()-0.5)*20
         enddo
         write(*,*)repeat(' -1 ',4)
         write(1,*)repeat(' -1 ',2)
      enddo
      write(1,*)' -1'
      close(1)
      end
