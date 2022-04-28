      program extrema
      implicit none
c     a quad read is declared to avoid real-literal-constant warning
      real(kind=16) quad
      write(*,'(t3,a,t16,a,t33,a,t59,a)')'integer','real','double'
     $     ,'quad'
      print *, huge(0), huge(0e0), huge(0d0), huge(quad), 'max'
      print *, 1, tiny(0e0), tiny(0d0), tiny(quad), 'min'
      write(*,*) 1, epsilon(0e0), epsilon(0d0), epsilon(quad), 'eps'
      end program extrema
