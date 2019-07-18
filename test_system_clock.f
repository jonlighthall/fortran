      PROGRAM test_system_clock
      implicit none
      INTEGER :: count, count_rate, count_max,remain,sec,min,hr
     &     ,day,delay,elap
      character(64) fmt,str
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      WRITE(*,*) count, count_rate, count_max
      remain=count_max-count
      call format(remain,str)
      write(*,*) 'There are ',trim(adjustl(str)),' units'
      sec=remain/count_rate
      call format(sec,str)
      write(*,*) '       or ',trim(adjustl(str)),' seconds'
      min=remain/count_rate/60
      call format(min,str)
      write(*,*) '       or ',trim(adjustl(str)),' minutes'
      hr=remain/count_rate/60/60
      call format(hr,str)
      write(*,*) '       or ',trim(adjustl(str)),' hours'
      day=remain/count_rate/60/60/24
      call format(day,str)
      write(*,*) '       or ',trim(adjustl(str)),
     &' days remaining before system clock rollover'
      write(*,*)repeat('-',30)
      write(fmt,*)'(1x,a,t12,i2,a)'    
      day=remain/count_rate/60/60/24
      write(*,fmt) 'There are ',day,' days'
      hr=(remain/count_rate-day*60*60*24)/60/60
      write(*,fmt) '      and ',hr,' hours'
      min=(remain/count_rate-day*60*60*24-hr*60*60)/60
      write(*,fmt) '      and ',min,' minutes'
      sec=(remain/count_rate-day*60*60*24-hr*60*60-min*60)
      write(*,fmt) '      and ',sec
     &     ,' seconds remaining before system clock rollover'
c     run for one cycle
      delay=count
      do while (delay.le.count)
         call system_clock(delay)
      enddo
c     run until rollover
      call sleep(remain/count_rate+10)

      WRITE(*,*) delay, count_rate, count_max
      if(delay.lt.count) then
         write(*,*)'rollover suspected'
         elap=(delay+count_max-count)/count_rate
      else
         elap=(delay-count)/count_rate
      endif
      write(*,*)'Program ran for ',elap,' seconds'
      END PROGRAM
