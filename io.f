      PROGRAM io
      integer, parameter :: n=100
      REAL, DIMENSION(N) :: A
      integer, parameter :: maxN=10
      logical ext
      integer i,j,k
      A=0
      WRITE(*,'(A,I6)') 'Creating array of size ',N
      if(N.gt.maxN)then
         j=maxN
         write(*,*) 'fill limited to ',j
      else
         j=N
      end if
      DO i = 1, j
         A(i) = i
      END DO

      k=size(A)
      write(*,*) 'array is of size', k
      inquire(file = 'svp.out', exist=ext)
      if(ext)then
         open(1,file = 'svp.out',status='old',position='append',action
     &        ='write')
      else
         open(1,file = 'svp.out',status='new',action='write')
      end if
      do i=1,k
         if(abs(A(i)).gt.0)then
            write(*,*) A(i)
            write(1,*) i, A(i)
         end if
      end do
      close(1)
      END PROGRAM

