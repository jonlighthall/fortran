      SUBROUTINE f(N)
      REAL, DIMENSION(N) :: A
      parameter (maxN=100)
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
c      print *, A                !! Print an entire array
      do i=1,N
         if(A(i).ne.0)then
            write(*,*) A(i)
         end if
      end do
      END SUBROUTINE
