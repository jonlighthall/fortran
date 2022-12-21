      program test_pi
      implicit none
      integer (kind=16) ii,ipi,test_val,pdp
      integer, parameter :: dp = 33
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk), parameter :: p = real(4,srk)*atan(real(1,srk))
      character (len=40) fmt
      logical  val_ok
      include 'pi_string.f'
      write(*,'(1x,i2,a,i2,a)')dp,' decimals reqested (using ',srk
     &     ,' bytes)'
      write(*,'(3x,4a)')ipistr(1:1),'.',ipistr(2:dp+1)
     &     ,' string (reference)'
      pdp=dp-1                  ! printed decimal places
      write(fmt,'(a,i0.2,a,i0.2,a)')'(3x,f',pdp+2,'.',pdp,',a)'
      write(*,fmt)p,'  atan (calculated)'

c     compare digits
      write(*,*)'comparing digits...'
      ii=0
      val_ok=.true.
      do while (val_ok)
         ipi=floor(p*10**real(ii,kind(p)),kind(ipi))
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
