      program formatted_integer
      implicit none
      include 'set_format.f'
      integer(kind=intsize) i,j,k,l
      character(len=fmtsize) str
      character(len=256) fmt
      i=floor(log10(real(huge(j))))
      write(fmt,*)'(a,i',ceiling(log10(real(intsize))),')'
      write(*,fmt)'for byte size ',intsize
      write(fmt,*)'(a,i',i+1,')'
      write(*,fmt)'testing formatting up to ',10**i+1
      write(fmt,*)'(1x,i',i+1,')'
      l=(i+1+ceiling((i+1)/3.))/2
      do j=0,i,3
         k=10**j
         write(*,*)repeat('-',l),k,repeat('-',l-1)
         do i =k-1,k+1
            write(*,fmt, advance = "no")i
            call format(i,str)
            write(*,*)adjustr(str)
         enddo
      enddo
      end
