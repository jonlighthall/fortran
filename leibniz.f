      program leibniz
      implicit none
      integer (kind=16) i,d,c,step,ii,ipi,test_val
      real (kind=8) r,p,last
      character (len=40) ipistr
      logical  val_ok
      ipistr = '31415926535897932384626433832795028841971693993751058'
c     calculate series
      i=0
      r=0
      d=1
      last=2
      step=1
      do while (last.ge.1d0/d)
         last=1d0/d
         d=2*i+1
         c=(-1)**i
         r=r+real(c)/d
         if(mod(i,step).eq.0) then
            p=4d0*r
            write(*,*)i,d,c,r,p,last,1d0/d
c     compare digits
      ii=0
      val_ok=.true.
      do while (val_ok)
         ipi=floor(p*10**ii,16)
         read(ipistr(1:ii+1),*)test_val
c         write(*,*)ii+1,ipi,test_val,ipi.eq.test_val
         if ((ipi.ne.test_val)) then
            val_ok=.false.
            write(*,'(1x,i2,a)')ii
     $           ,' decimal places of precision achieved'
            exit
         endif
         ii=ii+1
         step=10**ii
      enddo
         endif
         i=i+1
      enddo
      write(*,*)i,d,c,r,p
      end
