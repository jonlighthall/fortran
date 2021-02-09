      program dice
      implicit none
c     old
      integer i,j,k,count,r2d,rolls
      real u(2)
      logical jail

      integer :: seed_mode=1
      
      integer, allocatable :: seed(:)
      integer :: n
      call random_seed(size = n)
      allocate(seed(n))


      select case (seed_mode)

      case (1)
         seed(:)=1
         call random_seed(put=seed)

      case (2)
         call system_clock(count) ! get system time in milliseconds
         write(*,*)count
         seed(:)=count
c     seed(:)=seed+count
         write(*,*)seed
         call random_seed(put=seed)
         call random_seed(get=seed)
         write (*, *) seed

      case default
         call random_seed()
         call random_seed(get=seed)
         write (*, *) seed
      end select
      
      jail=.false.
      rolls=0;
c     do while (.not. jail)
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
