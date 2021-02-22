      program dice
      implicit none
      integer i,j,k,time,r2d,rolls
      real u(2)
      logical jail
      integer :: seed_mode=-1
      integer, allocatable :: seed(:)
      integer :: n
      integer :: count(6)

      call random_seed(size = n)
      allocate(seed(n))
      select case (seed_mode)
      case (1)
         seed(:)=1
         call random_seed(put=seed)
      case (2)
         call system_clock(count=time) ! get system time in milliseconds
         call random_seed(get=seed)
         write(*,*)'seed is'
         write(*,*) seed
         write(*,*)'The time is ',time
         seed(:)=time
         call random_seed(put=seed)
         call random_seed(get=seed)
         write(*,*)'seed is'
         write (*,*) seed
      case default
         call random_seed()
c     call random_seed(get=seed)
c     write (*, *) seed
      end select
      
      jail=.false.
      count=0
      rolls=0
      do while (.not. jail)
         
c      do i=1,5
         call random_number(u)
         j = r2d(u(1))
         k = r2d(u(2))
         write(*,'(a,i3,a,i1,a,i1,a,i2)')'Roll ',rolls,':',j,'+',k,'=',j
     &        +k
         count(j)=count(j)+1
         count(k)=count(k)+1
         if (j.eq.k) then       ! first double
            call random_number(u)
            j = r2d(u(1))
            k = r2d(u(2))
            count(j)=count(j)+1
            count(k)=count(k)+1
            write(*,'(a,i1,a,i1,a,i2,a)')'        :',j,'+',k,'=',j
     &           +k,' second roll'
            if (j.eq.k) then    ! second double
               call random_number(u)
               j = r2d(u(1))
               k = r2d(u(2))
               count(j)=count(j)+1
               count(k)=count(k)+1
               write(*,'(a,i1,a,i1,a,i2,a)')'        :',j,'+',k,'=',j+k
     &              ,' third roll'

               if (j.eq.k) then
                  write(*,*)'JAIL'
                  jail=.true.
               endif
            endif
         endif
         rolls=rolls+1
      enddo
      if(jail)then
         write(*,*)'it took ',rolls,'to go to jail'
      endif
      write(*,*)count
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
