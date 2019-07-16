      PROGRAM test_system_clock
      implicit none
      INTEGER :: count, count_rate, count_max,remain,sec,min,hr,day
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      WRITE(*,*) count, count_rate, count_max
      remain=count_max-count
      sec=remain/count_rate
      write(*,*) 'There are ',sec,' seconds remaining
     &     before rollover'
      min=remain/count_rate/60
      write(*,*) 'There are ',min,' minutes remaining
     &     before rollover'
      hr=remain/count_rate/60/60
      write(*,*) 'There are ',hr,' hours remaining
     &     before rollover'
      day=remain/count_rate/60/60/24
      write(*,*) 'There are ',day,' days remaining
     &     before rollover'


      END PROGRAM
