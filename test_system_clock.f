      PROGRAM test_system_clock
      implicit none
      INTEGER :: count, count_rate, count_max,remain,sec,min,hr,day
      integer delay,elap
      character(32) fmt
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      WRITE(*,*) count, count_rate, count_max
      remain=count_max-count
      WRITE(*,*) 'remain = ',remain
      write(fmt,*)'(a,t11,i2,a)'
      day=remain/count_rate/60/60/24
      write(*,fmt) 'There are ',day,' days'
      hr=(remain/count_rate-day*60*60*24)/60/60
      write(*,fmt) '      and ',hr,' hours'
      min=(remain/count_rate-day*60*60*24-hr*60*60)/60
      write(*,fmt) '      and ',min,' minutes'
      sec=(remain/count_rate-day*60*60*24-hr*60*60-min*60)
      write(*,fmt) '      and ',sec
     &     ,' seconds remaining before system clock rollover'
      call sleep(10)
      CALL SYSTEM_CLOCK(delay)
      if(delay.le.count) then
         write(*,*)'rollover suspected'
         elap=(delay+count_max-count)/count_rate
      else
         elap=(delay-count)/count_rate
      endif
      write(*,*)'Program ran for ',elap,' seconds'
      END PROGRAM
