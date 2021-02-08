      program dice
c     old
      integer :: count
      call system_clock(count)  ! get system time in milliseconds
      call srand(count)         ! use time for random seed
      print *, irand(), irand(), irand(), irand()
      print *, irand(count), irand(), irand(), irand()
c     
c     new
      n=1
      m=6
      do i=1,100
         call random_number(u)
         j = n + FLOOR((m+1-n)*u) ! We want to choose one from m-n+1 integers
         call random_number(v)
         k = n + FLOOR((m+1-n)*v) 
         write(*,*)j,k
         if (j.eq.k) then ! first double
            call random_number(u)
            j = n + FLOOR((m+1-n)*u)
            call random_number(v)
            k = n + FLOOR((m+1-n)*v) ! We want to choose one from m-n+1 integers
            write(*,*)j,k,"second roll"
            if (j.eq.k) then ! second double
               call random_number(u)
               j = n + FLOOR((m+1-n)*u) ! We want to choose one from m-n+1 integers
               call random_number(v)
               k = n + FLOOR((m+1-n)*v) ! We want to choose one from m-n+1 integers
               write(*,*)j,k, "third roll"
               if (j.eq.k) then
                  write(*,*)"JAIL"
               endif
            endif
         endif
      enddo
      end
