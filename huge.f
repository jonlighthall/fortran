      program biggest
      implicit none
      include 'set_format.f'
      integer(kind=intsize) :: i, j, k
      integer(kind=1) :: sz,ln
      character(len=fmtsize) str
      character(len=256) fmt
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

c     check result with huge intrinsic
      k=huge(i)
      if(k.eq.j)then
         write(*,*)'calculated maximum equals system maximum'
      else
         write(*,*)'calculated maximum does not equal system maximum'
         write(fmt,*)'(i',ln,',a,/,i',ln,')'
         write(*,fmt)j,' .ne. ',k
      endif

c     print formatted output
      call format(j,str)        ! watch for mismatched types
      if (str.ne.' -1') then
         write(*,'(a)')str
         write(*,'(a,i2)')'formatted length is ',len(trim(adjustl(str)))
      endif
      write(*,'(es9.1)')real(j)
      end

c     byte bit ln fl max
c     --   --- -- -- ---------------------------------------
c      1     8  3  3 127
c      2    16  5  6 32767
c      4    32 10 13 2147483647
c      8    64 19 25 9223372036854775807
c     16   128 39 51 170141183460469231731687303715884105727
