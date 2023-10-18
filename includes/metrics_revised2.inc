c     set decimal point precision
      integer, parameter :: set_precision = 20
      integer, parameter :: set_kind = selected_real_kind(set_precision)

c     equivalence definitions
      real(kind = set_kind), parameter :: ft2m=real(3048,set_kind)
     &     /real(10000,set_kind)
      real(kind = set_kind), parameter :: mi2m=1852
c     functional definitions
      real(kind = set_kind), parameter :: m2ft=real(1,set_kind)/ft2m
      real(kind = set_kind), parameter :: m2mi=real(1,set_kind)/mi2m
      real(kind = set_kind), parameter :: dB_m2yd=real(20,set_kind)
     &     *log10(real(3,set_kind)*ft2m)
      real(kind = set_kind), parameter :: ms2kt=m2mi*real(3600,set_kind)
      real(kind = set_kind), parameter :: kt2ms=real(1,set_kind)/ms2kt
