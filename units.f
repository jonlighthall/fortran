      program units
      implicit none
      integer, parameter :: nmi2m=1852, ift2m=3048
      integer, parameter :: dp = 8
      real(kind = selected_real_kind(dp)) ft2m,m2ft,m2nmi,m2yd,yd2m
     &     ,dB_m2yd,dB_yd2m
      write(*,*)'  nmi2m = ',nmi2m
      ft2m=ift2m/1e4
      write(*,*)'ft2m = ',ft2m
      m2ft=1/ft2m
      write(*,*)'m2ft = ',m2ft
      m2nmi=1./nmi2m
      write(*,*)'m2nmi = ',m2nmi
      m2yd=m2ft/3
      write(*,*)'m2yd = ',m2yd
      yd2m=1/m2yd
      write(*,*)'yd2m = ',yd2m
      dB_m2yd=20*log10(m2yd)
      write(*,*)'dB_m2yd = ',dB_m2yd
      dB_yd2m=20*log10(yd2m)
      write(*,*)'dB_yd2m = ',dB_yd2m
      end
