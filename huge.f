      program biggest
      implicit none
      integer*16 i, j, k
      integer*1 sz,ln
      character(64) fmt
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

c     print summary with calculated formats
      sz=sizeof(i)
      ln=ceiling(log10(real(sz)))
      write(fmt,*)'(a,i',ln,',a)'
      write(*,fmt)'in ',sz,' bytes'
      ln=ceiling(log10(real(j)))
      write(fmt,*)'(a,sp,i',ln+1,')'
      write(*,fmt) 'the highest signed integer is ', j
      write(*,fmt) ' the lowest signed integer is ', i
      k=ceiling(log10(real(ln)))
      if(ln.eq.10**k)k=k+1      ! needed for 4 bit
      write(fmt,*)'(i',ln,',a,i',k,',a)'
      write(*,fmt)j,' is ',ln,' digits long'
      k=huge(i)
      if(k.eq.j)then
         write(*,*)'calculated maximum equals system maximum'
      else
         write(*,*)'calculated maximum does not equal system maximum'
         write(*,*)j,'.ne.',k
      endif
      end
      
c      1 byte    8 bits 127
c      2 bytes  16 bits 32767
c      4 bytes  32 bits 2147483647
c      8 bytes  64 bits 9223372036854775807
c     16 bytes 128 bits 170141183460469231731687303715884105727
