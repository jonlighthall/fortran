      PROGRAM test_system_clock
      implicit none
      INTEGER(kind=4) :: count,count_rate,count_max
      integer :: start, finish
      include 'set_format.f'
      interface
         subroutine format(intj,str)
         include 'set_format.f'
         integer(kind=intsize) :: intj
         character str
         end subroutine
      end interface
      INTEGER(kind=intsize) :: remain,sec,min,hr,day,elap,ms
      character(len=fmtsize) str
      character(len=128) fmt,unit_name
      write(*,*)'in ',intsize,' bytes'
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      start=count
      WRITE(*,*) 'Time: ',count
      write(*,*) 'Rate: ',count_rate
      write(*,*) ' Max: ', count_max
      write(*,*)repeat('-',30)
      remain=int(count_max-count,intsize)
      if(count_rate.eq.1000) then
         write(unit_name,*) 'miliseconds'
      else
         write(unit_name,*) 'units'
      endif

      if(intsize.ge.4) then
c     print total time
         call format(remain,str)
         write(*,*) 'There are ',trim(adjustl(str)),trim(unit_name)
         sec=remain/int(count_rate,intsize)
         call format(sec,str)
         write(*,*) '       or ',trim(adjustl(str)),' seconds'
         min=remain/int(count_rate,intsize)/60
         call format(min,str)
         write(*,*) '       or ',trim(adjustl(str)),' minutes'
         hr=remain/int(count_rate,intsize)/60/60
         call format(hr,str)
         write(*,*) '       or ',trim(adjustl(str)),' hours'
         day=remain/int(count_rate,intsize)/60/60/24
         call format(day,str)
         write(*,*) '       or ',trim(adjustl(str)),
     &        ' days remaining before system clock rollover'
         write(*,*)repeat('-',30)
      else
         write(*,*)'no format'
      endif

c     print divided time
      write(fmt,*)'(1x,a,t12,i2,a)'
      day=remain/int(count_rate,intsize)/60/60/24
      write(*,fmt) 'There are ',day,' days'
      hr=(remain/int(count_rate,intsize)-day*60*60*24)/60/60
      write(*,fmt) '      and ',hr,' hours'
      min=(remain/int(count_rate,intsize)-day*60*60*24-hr*60*60)/60
      write(*,fmt) '      and ',min,' minutes'
      sec=(remain/int(count_rate,intsize)-day*60*60*24-hr*60*60-min*60)
      write(*,fmt) '      and ',sec
     &     ,' seconds remaining before system clock rollover'
      write(*,*)repeat('-',30)

c     run for one cycle
      finish=count              ! initialize finish
      do while (finish.eq.start)
         call system_clock(finish)
      enddo
      WRITE(*,*) 'Time: ',finish

c     calculate elapsed time
      if(finish.lt.start) then
         write(*,*)'rollover suspected'
         elap=(finish+count_max-start)
      else
         elap=(finish-start)
      endif

c     print elapsed time
      write(fmt,*)'(1x,a,t12,i2,2a)'
      day=elap/int(count_rate,intsize)/60/60/24
      write(*,fmt) 'There are ',day,' days'
      hr=(elap/int(count_rate,intsize)-day*60*60*24)/60/60
      write(*,fmt) '      and ',hr,' hours'
      min=(elap/int(count_rate,intsize)-day*60*60*24-hr*60*60)/60
      write(*,fmt) '      and ',min,' minutes'
      sec=(elap/int(count_rate,intsize)-day*60*60*24-hr*60*60-min*60)
      write(*,fmt) '      and ',sec,' seconds'
      ms=(elap-(day*60*60*24+hr*60*60+min*60+sec)*
     &     int(count_rate,intsize))
      write(*,fmt) '      and ',ms,trim(unit_name),' elapsed'
      END PROGRAM
