      program units
      implicit none
      integer (kind=16) i,pdp

c     set decimal point precision
c
c     for each real kind, the maximum number of decimal places is given
c     along with the maximum accurate (consistent) decimal place
c      
c     bytes max consistent
c     ----- --- ---------
c      4     6   6
c      8    15  14
c     10    18  14
c     16    33  32
      integer, parameter :: dp = 10
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk), parameter :: pi = 4q0*atan(1q0)
      real(kind = srk) sum,pival,seq,pireal
      character (len=40) pistr,fmt
      write(*,'(a,i2,a)')'in ',srk,' bytes'
      select case (precision(pi))
      case (6)
         pdp=6
      case (15)
         pdp=14
      case (18)
         pdp=14
      case (33)
         pdp=32
      end select
c      pdp=dp-1
      write(fmt,'(a,i0.2,a,i0.2,a)')'(3x,f',pdp+2,'.',pdp,',a)'

      pistr = '3.1415926535897932384626433832795028841971693993751058'
      write(*,'(3x,2a)')trim(pistr(1:dp+2)),' string'
      read(pistr,*)pireal
      write(*,fmt)pireal,'  real'
      write(*,fmt)pi,'  atan'
      sum=0
      i=1
      pival=0
      seq=2
      do while (seq.gt.1q0/(i*i))
         seq=1q0/(i*i)
         sum=sum + seq
         pival=sqrt(6q0*sum)
         i=i+1
      enddo
      write(*,fmt)pival,'  Basel'
      write(*,*)i,sum,pival
      end
