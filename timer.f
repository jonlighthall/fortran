      program timer
      implicit none
      INTEGER :: count,count_rate,count_max,sec,min,hr,day,elap,ms
      integer :: start, finish
      character(64) fmt
      logical interrupted
      common interrupted
      external catch_signal
      integer, parameter :: SIGINT = 2
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      start=count
      call signal(SIGINT, catch_signal)

      write(*,*)'Timer started...'
      write(*,*)'press Ctrl-c to stop'
      interrupted = .false.
      do 
         if(interrupted) exit
      enddo
      write(*,*)'...stopped'

      CALL SYSTEM_CLOCK(count)
      finish=count
      
c     calculate elapsed time
      if(finish.lt.start) then
         write(*,*)'rollover suspected'
         elap=(finish+count_max-start)
      else
         elap=(finish-start)
      endif

c     print elapsed time
      write(fmt,*)'(1x,a,t12,i4,a)'    
      day=elap/count_rate/60/60/24
      write(*,fmt) 'There are ',day,' days'
      hr=(elap/count_rate-day*60*60*24)/60/60
      write(*,fmt) '      and ',hr,' hours'
      min=(elap/count_rate-day*60*60*24-hr*60*60)/60
      write(*,fmt) '      and ',min,' minutes'
      sec=(elap/count_rate-day*60*60*24-hr*60*60-min*60)
      write(*,fmt) '      and ',sec,' seconds'
      ms=(elap-(day*60*60*24-hr*60*60-min*60)*count_rate)
      write(*,fmt) '      and ',ms,' units elapsed'
      end 

      subroutine catch_signal
      logical interrupted
      common interrupted
      interrupted = .true.
      end 
