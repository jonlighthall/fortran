      program huge
      implicit none
      integer*16 i, j, k
      i=1 
      j=0
      do while (i.gt.j)
         j=i
         i=i*2
      enddo
      do k=floor(log10(real(j))),0,-1
         i=j
         j=i-1
         do while (i.gt.j)
            j=i
            i=i+10**k
         enddo
      enddo
      write(*,*) 'the largest integer is', j
      end

c      1 byte    8 bits 127
c      2 bytes  16 bits 32767
c      4 bytes  32 bits 2147483647
c      8 bytes  64 bits 9223372036854775807
c     16 bytes 128 bits 170141183460469231731687303715884105727
