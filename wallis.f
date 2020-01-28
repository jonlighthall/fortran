      program leibniz
      implicit none
      integer (kind=16) i,d1,d2,n1,mx,ii,ipi,test_val,j
      real (kind=16) r,p,last
      character (len=40) ipistr
      logical  val_ok
      ipistr = '31415926535897932384626433832795028841971693993751058'
c     calculate series
      i=0
      r=1
      d1=1
      last=3
      mx=1000
      ii=0
      do j=1,8
         do while (ii.lt.j)
            d1=2*i+1
            n1=2*(i+1)
            d2=2*(i+1)+1
            r=r*real(n1)/d1*real(n1)/d2
            last=r
            if((mod(i,mx/10).eq.0).or.(j.eq.1)) then
               p=2d0*r
c     write(*,*)i,d1,n1,d2,r,p,last
c     compare digits
               ii=0
               val_ok=.true.
               do while (val_ok)
                  ipi=floor(p*10**ii,16)
                  read(ipistr(1:ii+1),*)test_val
c     write(*,*)ii+1,ipi,test_val,ipi.eq.test_val
                  if ((ipi.ne.test_val)) then
                     val_ok=.false.
c     write(*,'(1x,i2,a)')ii
c     $                 ,' decimal places of precision achieved'
                     exit
                  endif
                  ii=ii+1
               enddo
c     write(*,*)i,d1,n1,d2,r,p,last,ii
            endif
            i=i+1
         enddo
         write(*,*)i,d1,n1,d2,r,p,ii
      enddo
      end
