      program leibniz
      implicit none
      integer (kind=16) i,d,c,mx
      real (kind=16) r,p
c     calculate series
      i=0
      r=0
      d=1/2
      mx=100000000
      do while (i.lt.mx)
         d=2*i+1
         c=(-1)**i
         r=r+real(c)/d
         if(mod(i,mx/10).eq.0) then
            write(*,*)i,d,c,r,4*r
         endif
         i=i+1
      enddo
      p=4d0*r
      write(*,*)i,d,c,r,p
      end
