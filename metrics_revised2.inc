      integer, parameter :: set_precision = 19
      integer, parameter :: set_kind = selected_real_kind(set_precision)

c     equivalence definitions
      real(kind = set_kind), parameter :: ft2m=3048q-4
      real(kind = set_kind), parameter :: mi2m=1852q0
c     functional definitions
      real(kind = set_kind), parameter :: m2ft=1q0/ft2m
      real(kind = set_kind), parameter :: m2mi=1q0/mi2m
      real(kind = set_kind), parameter :: dB_m2yd=20d0*log10(3q0*ft2m)  
      real(kind = set_kind), parameter :: ms2kt=m2mi*6q1*6q1            
      real(kind = set_kind), parameter :: kt2ms=1q0/ms2kt
