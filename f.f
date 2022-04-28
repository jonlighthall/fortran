      SUBROUTINE f(N)
      integer N,maxN,i,j,k
      REAL, DIMENSION(N) :: A
      parameter (maxN=10)
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
      do i=1,k
         if(A(i).ne.0)then
            write(*,*) A(i)
         end if
      end do
      END SUBROUTINE
