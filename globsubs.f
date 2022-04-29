      program globsubs
c     I/O units & option switches
      include 'araydim.inc'
      integer,parameter :: mr=100000,mz=mxZ,mp=10
      print *, "global test"
      write(*,*) 'mxZ = ',mxZ
      write(*,*) 'mr = ',mr,'mz = ',mz,'mp = ',mp
      call f(mz)
      end
