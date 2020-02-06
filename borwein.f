      program borwein
      implicit none
      integer(kind=16) i,ii,ipi,test_val
      real(kind=16)a,b,p
      character (len=40) ipistr
      logical  val_ok
      ipistr = '31415926535897932384626433832795028841971693993751058'
c     calculate series
      i=0
      a=sqrt(2q0)
      b=0q0
      p=2q0+sqrt(2q0)
      ii=0
      do while (a.ne.1q0)
         b=((1q0+b)*sqrt(a))/(a+b)
         a=(sqrt(a)+1q0/sqrt(a))/2q0
         p=((1q0+a)*p*b)/(1q0+b)
         write(*,*)i,a,b,p
c     compare digits

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
