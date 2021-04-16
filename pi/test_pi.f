      program test_pi
      implicit none
      integer (kind=16) i,ii,ipi,test_val,pdp
      integer, parameter :: dp = 33
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk), parameter :: p = 4.q0*atan(1.q0)
      character (len=40) ipistr,fmt
      logical  val_ok
      write(*,'(1x,i2,a,i2,a)')dp,' decimals reqested (using ',srk
     &     ,' bytes)'
      ipistr = '31415926535897932384626433832795028841971693993751058'
      write(*,'(3x,4a)')ipistr(1:1),'.',ipistr(2:dp+1),' string'
      pdp=dp-1                  ! printed decimal places
      write(fmt,'(a,i0.2,a,i0.2,a)')'(3x,f',pdp+2,'.',pdp,',a)'
      write(*,fmt)p,'  atan'

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
     $           ,' decimal places of precision achieved'
            exit
         endif
         ii=ii+1
      enddo
      end
