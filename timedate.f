      program test_time_and_date
c      character(8)  :: date
c      character(10) :: time
c      character(5)  :: zone
      integer,dimension(8) :: values
! using keyword arguments
c      call date_and_time(date,time,zone,values)
c      call date_and_time(DATE=date,ZONE=zone)
c      call date_and_time(TIME=time)
      call date_and_time(VALUES=values)
c     print '(a,2x,a,2x,a)', date, time, zone
      print '(8i5)', values
      write(*,'(a,i0.2,a,i0.2,a,i4)')'the date is ',values(2),'/'
     &     ,values(3),'/',values(1)
      write(*,'(a,i0.2,a,i0.2,a,i0.2,a,i0.3,a,sp,i0.2,a)')'the time is '
     &     ,values(5),':',values(6),':',values(7),'.',values(8),' '
     &     ,values(4)/60,' UTC'
      end program test_time_and_date
