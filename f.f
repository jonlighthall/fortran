      SUBROUTINE f(N)
      integer N,maxN,i,j,k
      REAL, DIMENSION(N) :: A
c     set array size limit
      parameter (maxN=10)
      A=0
      WRITE(*,'(A,I6)') 'Filling array of size ',N
c
c     check size against limit
      if(N.gt.maxN)then
         j=maxN
         write(*,*) 'fill limited to ',j
      else
         j=N
      end if
c
c     fill array
      DO i = 1, j
         A(i) = i
      END DO

      k=size(A)
      write(*,*) 'array is of size', k
      do i=1,k
         if(abs(A(i)).gt.0)then
            write(*,*) A(i)
         end if
      end do
      END SUBROUTINE
