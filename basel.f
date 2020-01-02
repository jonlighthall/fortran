      program units
      implicit none
      real(kind = 10), parameter :: pi = 4q0*atan(1q0)
      integer (kind=16) i
      real(kind = 10) sum,pival,seq
      character (len=128) pistr
      pistr = '  3.1415926535897932384626433832795028841971693993751058'
      write(*,*)trim(pistr)
      write(*,*)pi
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
      write(*,*)pival
      write(*,*)i,sum,pival
      end
