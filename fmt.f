      program fmt
      implicit none
      include 'set_format.f'
      integer(kind=intsize) i,j,k
      character(len=fmtsize) dummy,sfmt
      i=floor(log10(real(huge(j))))
      write(sfmt,*)'(a,i',ceiling(log10(real(intsize))),')'
      write(*,sfmt)'for byte size ',intsize
      write(sfmt,*)'(a,i',i+1,')'
      write(*,sfmt)'testing formatting up to ',10**i+1
      write(sfmt,*)'(1x,i',i+1,')'
      do j=0,i
         k=10**j
         write(*,*)repeat('-',10),k,repeat('-',10)
         do i =k-1,k+1
            write(*,sfmt, advance = "no")i
            call format(i,dummy)
            write(*,*)adjustr(dummy)
         enddo
      enddo
      end
