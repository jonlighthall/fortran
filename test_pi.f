      program test_pi
      implicit none
      integer (kind=16) i,pdp,j,k
      integer, parameter :: dp = 15
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk), parameter :: pi = 4.d0*atan(1.d0)
      real(kind = srk) pireal,sum
      character (len=40) pistr,fmt
      write(*,'(1x,i2,a,i2,a)')dp,' decimals reqested (using ',srk
     &     ,' bytes)'
      pdp=dp-1
      write(fmt,'(a,i0.2,a,i0.2,a)')'(3x,f',pdp+2,'.',pdp,',a)'
      pistr = '3.1415926535897932384626433832795028841971693993751058'
      write(*,'(3x,2a)')trim(pistr(1:dp+2)),' string'
      read(pistr,*)pireal
      write(*,fmt)pireal,'  real'
      write(*,fmt)pi,'  atan'

      do i=0,dp
         write(*,*)i,floor(pireal*10**i),floor(pi*10**i)
         if (floor(pireal*10**i).ne.floor(pi*10**i)) exit
      enddo
      write(*,'(1x,i2,a)')i,' decimal places of precision achieved'
      end
