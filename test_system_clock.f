      PROGRAM test_system_clock
      implicit none
      INTEGER :: count, count_rate, count_max,remain,sec,min,hr
     &     ,day,delay,elap
      character(64) fmt,dum,dummy
      write(dum,*)
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      WRITE(*,*) count, count_rate, count_max
      remain=count_max-count
      write(dum,*)remain
      call format(remain,dummy)
c      write(*,*)dummy
      write(*,*) 'There are ',remain,' units'
      write(*,*) 'There are ',trim(adjustl(dummy)),' units'
      sec=remain/count_rate
      write(dum,*)sec
      call format(sec,dummy)
      write(*,*) '       or ',sec,' seconds'
      write(*,*) '       or ',trim(adjustl(dummy)),' seconds'
      min=remain/count_rate/60
      write(dum,*)min
      call format(min,dummy)
      write(*,*) '       or ',trim(adjustl(dummy)),' minutes'
      write(*,*) '       or ',min,' minutes'
      hr=remain/count_rate/60/60
      write(dum,*)hr
      call format(hr,dummy)
      write(*,*) '       or ',hr,' hours'
      write(*,*) '       or ',trim(adjustl(dummy)),' hours'
      day=remain/count_rate/60/60/24
      write(*,*) '       or ',day,
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
c      call sleep(10)
      CALL SYSTEM_CLOCK(delay)
c      delay=15
      if(delay.le.count) then
         write(*,*)'rollover suspected'
         elap=(delay+count_max-count)/count_rate
      else
         elap=(delay-count)/count_rate
      endif
      write(*,*)'Program ran for ',elap,' seconds'
      END PROGRAM

 

