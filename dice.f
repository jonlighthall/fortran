      program dice
      implicit none
      integer i,j,k,time,r2d,rolls
      real u(2)
      logical jail
      integer :: seed_mode=2
      integer, allocatable :: seed(:)
      integer :: n,lim
      integer :: count(6)
      real :: prob(6)

      call random_seed(size = n)
      allocate(seed(n))
      select case (seed_mode)
      case (1)
         write(*,*)'Seeding with fixed integer'
         write(*,*)'old seed is'
         write(*,*) seed
         seed(:)=1
         call random_seed(put=seed)
         call random_seed(get=seed)
         write(*,*)'new seed is'
         write (*,*) seed
      case (2)
         write(*,*)'Seeding with system time'
         call system_clock(count=time) ! get system time in milliseconds
         call random_seed(get=seed)
         write(*,*)'old seed is'
         write(*,*) seed
         write(*,*)'The time is '
         write(*,*)time
         seed(:)=seed(:)+time
         call random_seed(put=seed)
         call random_seed(get=seed)
         write(*,*)'new seed is'
         write (*,*) seed
      case default
         write(*,*)'Seeding with default'
         call random_seed()
         call random_seed(get=seed)
         write(*,*)'see is'
         write (*, *) seed
      end select
      
      jail=.false.
      count=0
      rolls=0
      lim=10                    ! write limit
c     do while (.not. jail)
      do i=1,500000
         call random_number(u)
         rolls=rolls+1
         j = r2d(u(1))
         k = r2d(u(2))
         if (rolls.le.lim) then
            write(*,'(a,i3,a,i1,a,i1,a,i2)')'Roll ',rolls,':',j,'+',k
     &           ,'=',j+k
         endif
         count(j)=count(j)+1
         count(k)=count(k)+1
         if (j.eq.k) then       ! first double
            call random_number(u)
            j = r2d(u(1))
            k = r2d(u(2))
            count(j)=count(j)+1
            count(k)=count(k)+1
            if (rolls.le.lim) then
               write(*,'(a,i1,a,i1,a,i2,a)')'        :',j,'+',k,'=',j
     &              +k,' second roll'
            end if
            if (j.eq.k) then    ! second double
               call random_number(u)
               j = r2d(u(1))
               k = r2d(u(2))
               count(j)=count(j)+1
               count(k)=count(k)+1
               if (rolls.le.lim) then
                  write(*,'(a,i1,a,i1,a,i2,a)')'        :',j,'+',k,'=',j
     &                 +k,' third roll'
               endif
               if (j.eq.k) then
                  if (rolls.le.lim) then
                     write(*,*)'JAIL'
                  endif
                  jail=.true.
               endif
            endif
         endif
      enddo
      if(jail)then
         write(*,*)'it took ',rolls,'to go to jail'
      endif
      write(*,*)count
      prob=real(count)/real(sum(count))
      write(*,*)prob
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
