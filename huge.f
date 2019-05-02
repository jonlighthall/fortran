      program huge
      implicit none
      integer*4 i, j, k
      real r
      i=1 
      j=0
      do while (i.gt.j)
         j=i
         i=i*2
      enddo
      write(*,*)i,j,'power'
      r=log10(real(j))
      do k=floor(r),0,-1
         i=j
         j=i-1
         do while (i.gt.j)
            j=i
            i=i+10**k
         enddo
         write(*,*)i,j,k,'decade'
      enddo
      write(*,*) 'the largest integer is', j
      end

c     1 byte  127
c     2 bytes 32767
c     4 bytes 2147483647
