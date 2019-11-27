      program fmt
      implicit none
      include 'set_format.f'
      integer(kind=intsize) i,j,k
      character(len=fmtsize) dummy
      do j=0,6
         k=10**j
         write(*,*)repeat('-',10),k,repeat('-',10)
         do i =k-1,k+1
            write(*,'(i7)', advance = "no")i
            call format(i,dummy)
            write(*,*)dummy
         enddo
      enddo
      end
