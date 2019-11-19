      program units
      integer(kind=2), parameter :: nmi2m=1852, ift2m=3048
      real(8) ft2m,m2ft,m2nmi,m2yd,dB_m2yd
      write(*,*)'nmi2m = ',nmi2m
      ft2m=ift2m/1e4
      write(*,*)'ft2m = ',ft2m
      m2ft=1/ft2m
      write(*,*)'m2ft = ',m2ft
      m2nmi=1./nmi2m
      write(*,*)'m2nmi = ',m2nmi
      m2yd=m2ft/3
      write(*,*)'m2yd = ',m2yd
      dB_m2yd=20*log10(m2yd)
      write(*,*)'dB_m2yd = ',dB_m2yd
      end
