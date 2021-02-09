      program dice
      implicit none
c     old
      integer j,k,count,r2d,rolls
      real u,v
      logical jail
      call system_clock(count)  ! get system time in milliseconds
c     
c     new
      jail=.false.
      rolls=0;
      do while (.not. jail)
c     do i=1,100
         call random_number(u)
         j = r2d(u)
         call random_number(v)
         k = r2d(v)
         write(*,*)j,k
         if (j.eq.k) then ! first double
            call random_number(u)
            j = r2d(u)
            call random_number(v)
            k = r2d(v)
            write(*,*)j,k,"second roll"
            if (j.eq.k) then ! second double
               call random_number(u)
               j = r2d(u)
               call random_number(v)
               k = r2d(v)
               write(*,*)j,k, "third roll"
               if (j.eq.k) then
                  write(*,*)"JAIL"
                  jail=.true.
               endif
            endif
         endif
         rolls=rolls+1
      enddo
      write(*,*)"it took ",rolls,"to go to jail"
      end
c
      integer function r2d(u)
c     random to dice
      real u
      integer n,m
      n=1
      m=6
      r2d = n + FLOOR((m+1-n)*u) ! We want to choose one from m-n+1 integers
      return
      end
