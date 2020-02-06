      program extrema
      implicit none
      write(*,'(t3,a,t16,a,t33,a,t59,a)')'integer','real','double'
     $     ,'quad'
      print *, huge(0), huge(0e0), huge(0d0), huge(0q0), 'max'
      print *, 1, tiny(0e0), tiny(0d0), tiny(0q0), 'min'
      write(*,*) 1, epsilon(0e0), epsilon(0d0), epsilon(0q0), 'eps'
      end program extrema
