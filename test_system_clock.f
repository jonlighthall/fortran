      PROGRAM test_system_clock
      implicit none
      INTEGER :: count, count_rate, count_max,remain
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      WRITE(*,*) count, count_rate, count_max
      remain=count_max-count
      write(*,*) 'There are ',remain/count_rate,' seconds remaining
     &     before rollover'
      END PROGRAM
