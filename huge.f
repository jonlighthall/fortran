      program huge
      implicit none
      integer*1 i, j
      logical mono
      i=1                       ! 2147483600
      mono=.true.
      do while (mono)
         j=i
         i=i+1
         if (i.le.j) mono=.false. ! check if monotonically increasing
      enddo
      write(*,*)i,j
      end
