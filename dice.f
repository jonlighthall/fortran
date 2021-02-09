      program dice
      implicit none
c     old
      integer i,j,k,count,r2d,rolls
      real u(2)
      logical jail
      call system_clock(count)  ! get system time in milliseconds
      call random_seed(count)
c     
c     new
      jail=.false.
      rolls=0;
c      do while (.not. jail)
      do i=1,10
         call random_number(u)
         j = r2d(u(1))
         k = r2d(u(2))
         write(*,*)j,k
         if (j.eq.k) then       ! first double
            call random_number(u)
            j = r2d(u(1))
            k = r2d(u(2))
            write(*,*)j,k,"second roll"
            if (j.eq.k) then    ! second double
               call random_number(u)
               j = r2d(u(1))
               k = r2d(u(2))
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
