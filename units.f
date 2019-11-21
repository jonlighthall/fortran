      program units
      implicit none
c     equivalence definitions
      integer, parameter :: nmi2m=1852, ift2m=3048
c     set decimal point precision
c     byts max
c     ---- ---
c      4    6
c      8   15
c     10   18
c     16   33
c     tested consistent out to 32 decimal places
      integer, parameter :: dp = 33
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk) ft2m,m2ft,m2nmi,m2yd,yd2m,dB_m2yd,dB_yd2m,kt2ms
     &     ,ms2kt
      character(len = 256) :: fmt

c     formatting
      write(fmt,'(a,i02,a)')'(a,i',ceiling(log10(real(dp))),')'
      write(*,fmt)'decimal palces = ',dp
      write(*,fmt)'real bytes = ',srk
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',dp+3,'.',dp,')'
c     write(fmt,'(a,i0.2,a,i0.2,a)')'(a,e',dp+7,'.',dp,')'

c     functional definitions
      ft2m=ift2m                ! must copy integer value first for ultimate precision
      ft2m=ft2m/1e4             ! works
      m2ft=1/ft2m
      m2nmi=1./nmi2m
      m2yd=m2ft/3
      yd2m=1/m2yd
      dB_m2yd=20*log10(m2yd)
      dB_yd2m=20*log10(yd2m)
      kt2ms=nmi2m/(60.*60)
      ms2kt=m2nmi*60*60

c     printed output
      write(*,'(a,i4)')'  nmi2m = ',nmi2m
      write(*,fmt)'   ft2m = ',ft2m
      write(*,fmt)'   m2ft = ',m2ft
      write(*,fmt)'  m2nmi = ',m2nmi
      write(*,fmt)'   m2yd = ',m2yd
      write(*,fmt)'   yd2m = ',yd2m
      write(*,fmt)'dB_m2yd = ',dB_m2yd
      write(*,fmt)'dB_yd2m = ',dB_yd2m
      write(*,fmt)'  kt2ms = ',kt2ms
      write(*,fmt)'  ms2kt = ',ms2kt
      end
