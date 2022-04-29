      program global
c     I/O units & option switches
      include 'araydim.inc'
      real, parameter :: mr=100000,mz=mxZ,mp=10
      print *, "global test"
      write(*,*) 'mxZ = ',mxZ
      write(*,*) 'mr = ',mr,'mz = ',mz,'mp = ',mp
      end program global
