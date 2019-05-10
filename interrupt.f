      subroutine catch_signal
      logical interrupted
      common interrupted
      interrupted = .true.
      write(*,*) 'in catch, interrupted = ',interrupted
      end 

      program crcount
      integer i,the_start,the_end,stat
      logical interrupted
      common interrupted
      external catch_signal
      integer, parameter :: SIGINT = 2
      
      call signal(SIGINT, catch_signal)
!     Try to recover current state
      open(1,file='state',status='old',action='read',iostat=stat)
      if (stat.eq.0) then
         read(1,*),the_start
         write(*,*)'coninuing from ',the_start
      else
!     Otherwise bootstrap at 1 
         the_start=1
         write(*,*)'starting from ',the_start
      end if
      close(1)

      the_end=10
      interrupted = .false.
      write(*,*) 'before loop, interrupted = ',interrupted
      do i = the_start,the_end
         if(interrupted) then
            write(*,*) 'in if, interrupted = ',interrupted
            exit
         endif
!     Heavy computations
         write(*,*) i,interrupted
         call Sleep(1)
      end do
      if (i.ge.the_end) write(*,*)'end reached',the_end
      write(*,*)'exit loop',interrupted

!     Save current state
      open(1,file='state',status='REPLACE',action='WRITE',iostat=stat)
      write(1,'(i2)')i
      close(1)
      end 
