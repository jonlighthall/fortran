      program wallis
      implicit none
      integer (kind=16) i,d1,d2,n1,step,ii,ipi,test_val,j
      real (kind=8) r,p
      logical  val_ok
      include 'pi_string.f'
c     calculate series
      i=0
      r=1
      d1=1
      step=1
      ii=0
      do j=1,8                  ! over 8 takes too long
         do while (ii.lt.j)
            d1=2*i+1
            n1=2*(i+1)
            d2=2*(i+1)+1
            r=r*real(n1)/d1*real(n1)/d2
            if((mod(i,step).eq.0).or.(j.eq.1)) then
               p=2d0*r
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
         write(*,'(4i10,2f13.10,i2)')i,d1,n1,d2,r,p,ii
      enddo
      write(*,'(1x,i2,a)')ii,' decimal places of precision achieved'
      end
