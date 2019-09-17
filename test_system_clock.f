      PROGRAM test_system_clock
      implicit none
      INTEGER :: count, count_rate, count_max,remain,sec,min,hr
     &     ,day,delay,elap,ms
      character(64) fmt,str,unit_name
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      WRITE(*,*) count, count_rate, count_max
      remain=count_max!-count
      if(count_rate.eq.1000) then
         write(unit_name,*) 'miliseconds'
      else
         write(unit_name,*) 'units'
      endif

c     print total time
      call format(remain,str)
      write(*,*) 'There are ',trim(adjustl(str)),trim(unit_name)
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

c     print divided time
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
      write(*,*)repeat('-',30)

c     run for one cycle
      delay=count
      do while (delay.eq.count)
         call system_clock(delay)
      enddo

      WRITE(*,*) delay, count_rate, count_max
      if(delay.lt.count) then
         write(*,*)'rollover suspected'
         elap=(delay+count_max-count)
      else
         elap=(delay-count)
      endif
      call format(elap/count_rate,str)

c     print elapsed time
      day=elap/count_rate/60/60/24
      write(*,fmt) 'There are ',day,' days'
      hr=(elap/count_rate-day*60*60*24)/60/60
      write(*,fmt) '      and ',hr,' hours'
      min=(elap/count_rate-day*60*60*24-hr*60*60)/60
      write(*,fmt) '      and ',min,' minutes'
      sec=(elap/count_rate-day*60*60*24-hr*60*60-min*60)
      write(*,fmt) '      and ',sec,' seconds'
      ms=(elap-(day*60*60*24-hr*60*60-min*60)*count_rate)
      write(*,fmt) '      and ',ms
     &     ,trim(unit_name),' elapsed'
      END PROGRAM
