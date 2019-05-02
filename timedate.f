      program test_time_and_date
      integer,dimension(8) :: values
       call date_and_time(VALUES=values)
      print '(8i5)', values
      write(*,'(a,i0.2,a,i0.2,a,i4)')'the date is ',values(2),'/'
     &     ,values(3),'/',values(1)
      write(*,'(a,i0.2,a,i0.2,a,i0.2,a,i0.3,a,sp,i0.2,a)')'the time is '
     &     ,values(5),':',values(6),':',values(7),'.',values(8),' '
     &     ,values(4)/60,' UTC'
      start=values(6)*60.+values(7)+values(8)/1000.
      write(*,'(a,f8.3)') 'start time is ', start
      call date_and_time(VALUES=values)
      finish=values(6)*60.+values(7)+values(8)/1000.
      write(*,'(a,f8.3)') '  end time is ', finish
      write(*,'(a,f8.3)') '  run time is ', finish-start
      end program test_time_and_date
