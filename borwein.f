      program borwein
      implicit none
      real(16)a,b,p
      integer(16) ii,i,ipi,test_val
      character (len=40) ipistr
      logical  val_ok
      a=sqrt(2d0)
      b=0d0
      p=2d0+sqrt(2d0)
      ipistr = '31415926535897932384626433832795028841971693993751058'
      i=0
      do while (a.ne.1d0)
         b=((1d0+b)*sqrt(a))/(a+b)
         a=(sqrt(a)+1d0/sqrt(a))/2d0
         p=((1d0+a)*p*b)/(1d0+b)
         write(*,*)i,a,b,p

c     compare digits
         ii=0
         val_ok=.true.
         do while (val_ok)
            ipi=floor(p*10**ii,16)
            read(ipistr(1:ii+1),*)test_val
            write(*,*)ii+1,ipi,test_val,ipi.eq.test_val
            if ((ipi.ne.test_val)) then
               val_ok=.false.
               write(*,'(1x,i2,a)')ii
     $              ,' decimal places of precision achieved'
               exit
            endif
            ii=ii+1
         enddo
         i=i+1
      enddo
      end 
