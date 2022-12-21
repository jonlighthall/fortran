      program borwein
      implicit none
      integer(kind=16) i,ii,ipi,test_val
      integer,parameter :: srk=16
      real(kind=srk)a,b,p
      logical  val_ok
      include 'pi_string.f'
      
c     calculate series
      i=0
c     quadratic convergce (1984)
      a=sqrt(real(2,srk))
      b=real(0,srk)
      p=real(2,srk)+sqrt(real(2,srk))
      ii=0
      do while ((a-real(1,srk)).gt.0)
         b=((real(1,srk)+b)*sqrt(a))/(a+b)
         a=(sqrt(a)+real(1,srk)/sqrt(a))/real(2,srk)
         p=((real(1,srk)+a)*p*b)/(real(1,srk)+b)
         write(*,*)i,a,b,p
c     compare digits

         val_ok=.true.
         do while (val_ok)
            ipi=floor(p*10**real(ii,kind(p)),kind(ipi))
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
