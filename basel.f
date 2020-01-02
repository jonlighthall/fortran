      program units
      implicit none
      integer, parameter :: dp = 15
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk), parameter :: pi = 4d0*atan(1d0)
      integer i
      real(kind = srk) sum,pival
      write(*,*)pi
      sum=0
      do i=1,50000
         sum=sum + 1d0/(i*i)
         pival=sqrt(6d0*sum)


      enddo
      write(*,*)i,sum,pival
      end
