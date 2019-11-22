      program units
      implicit none
c     equivalence definitions
      integer, parameter :: ift2m=3048
c     set decimal point precision
c
c     for each real kind, the maximum number of decimal places is given
c     along with the maximum accurate (consistent) decimal place
c      
c     bytes max consistent
c     ----- --- ---------
c      4     6   6
c      8    15  14
c     10    18  14
c     16    33  32
      integer, parameter :: dp = 18
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk) nmi2m,ft2m,m2ft,m2nmi,m2yd,yd2m,dB_m2yd,dB_yd2m
     &     ,kt2ms,ms2kt
      character(len = 256) :: fmt
      real(kind = 4) snmi2m,sft2m,sm2ft,sm2yd,syd2m,sdB_m2yd,sdB_yd2m
      real(kind = 8) dnmi2m,dft2m,dm2ft,dm2yd,dyd2m,ddB_m2yd,ddB_yd2m
      integer pdp

      write(*,*)'single precision'
      pdp=6
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
c     equivalence definitions
      sft2m=3048e-4
c     functional definitions
      sm2ft=1/sft2m
      sm2yd=sm2ft/3
      syd2m=1/sm2yd
      sdB_m2yd=20*log10(sm2yd)
      sdB_yd2m=20*log10(syd2m)

c     printed output
      write(*,fmt)'   ft2m = ',sft2m
      write(*,fmt)'   m2ft = ',sm2ft
      write(*,fmt)'   m2yd = ',sm2yd
      write(*,fmt)'   yd2m = ',syd2m
      write(*,fmt)'dB_m2yd = ',sdB_m2yd
      write(*,fmt)'dB_yd2m = ',sdB_yd2m
      
      write(*,*)
      write(*,*)'double precision'
      pdp=14
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
c     equivalence definitions
      dft2m=3048d-4
c     functional definitions
      dm2ft=1/dft2m
      dm2yd=dm2ft/3
      dyd2m=1/dm2yd
      ddB_m2yd=20*log10(dm2yd)
      ddB_yd2m=20*log10(dyd2m)

c     printed output
      write(*,fmt)'   ft2m = ',dft2m
      write(*,fmt)'   m2ft = ',dm2ft
      write(*,fmt)'   m2yd = ',dm2yd
      write(*,fmt)'   yd2m = ',dyd2m
      write(*,fmt)'dB_m2yd = ',ddB_m2yd
      write(*,fmt)'dB_yd2m = ',ddB_yd2m

      write(*,*)
      if(srk.ge.16) then
         write(*,*)'quad precision'
         pdp=32
         ft2m=3048q-4           ! works for real*16, not real*10
      else
         write(*,*)'specified precision'
         pdp=dp
         ft2m=ift2m             ! must copy integer value first for ultimate precision
         ft2m=ft2m/1q4          ! works
      endif

c     formatting
      write(fmt,'(a,i02,a)')'(a,i',ceiling(log10(real(pdp))),')'
      write(*,fmt)'decimal palces = ',dp
      write(*,fmt)'real bytes = ',srk

c     equivalence definitions
      nmi2m=1852q0

c     functional definitions
      m2nmi=1q0/nmi2m
      ms2kt=m2nmi*6q1*6q1
      kt2ms=1q0/ms2kt

c     printed output
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp-3,')'
c     write(fmt,'(a,i0.2,a,i0.2,a)')'(a,e',pdp+7,'.',pdp,')'
      write(*,fmt)'  nmi2m = ',nmi2m

      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
c     write(fmt,'(a,i0.2,a,i0.2,a)')'(a,e',pdp+7,'.',pdp,')'
      write(*,fmt)'  m2nmi = ',m2nmi
      write(*,fmt)'  kt2ms = ',kt2ms
      write(*,fmt)'  ms2kt = ',ms2kt
      write(*,*)
      
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'

c     equivalence definitions
      nmi2m=1852q0

c     functional definitions
      m2ft=1q0/ft2m
      m2yd=m2ft/3q0
      yd2m=1q0/m2yd
      dB_m2yd=20q0*log10(m2yd)
      dB_yd2m=20q0*log10(yd2m)

c     printed output
      write(*,fmt)'   ft2m = ',ft2m
      write(*,fmt)'   m2ft = ',m2ft
      write(*,fmt)'   m2yd = ',m2yd
      write(*,fmt)'   yd2m = ',yd2m
      write(*,fmt)'dB_m2yd = ',dB_m2yd
      write(*,fmt)'dB_yd2m = ',dB_yd2m
      end
