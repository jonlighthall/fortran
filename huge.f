      program huge
      implicit none
      integer*1 i, j
      i=1 
      j=0
      do while (i.gt.j)
         j=i
         i=i+1
      enddo
      write(*,*)i,j
      end

c     1 byte  127
c     2 bytes 32767
c     4 bytes 2147483647
