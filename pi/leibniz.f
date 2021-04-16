      program leibniz
      implicit none
      integer (kind=16) i,d,c,step,ii,ipi,test_val,j
      real (kind=8) r,p
      character (len=40) ipistr
      logical  val_ok
      ipistr = '31415926535897932384626433832795028841971693993751058'
c     calculate series
      i=0
      r=0
      d=1
      step=1
      ii=0
      do j=1,8
         do while (ii.lt.j)
            d=2*i+1
            c=(-1)**i
            r=r+real(c)/d
            if((mod(i,step).eq.0).or.(j.eq.1)) then
               p=4d0*r
c     compare digits
               ii=j-1
               val_ok=.true.
               do while (val_ok)
                  ipi=floor(p*10**ii,16)
                  read(ipistr(1:ii+1),*)test_val
                  if ((ipi.ne.test_val)) then
                     val_ok=.false.
                     exit
                  endif
                  ii=ii+1
                  step=i
               enddo
            endif
            i=i+1
         enddo
         write(*,*)i,d,c,r,p,ii
      enddo
      write(*,'(1x,i2,a)')ii,' decimal places of precision achieved'
      end
