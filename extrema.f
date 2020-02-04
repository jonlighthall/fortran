      program extrema
      write(*,'(t3,a,t16,a,t33,a,t59,a)')'integer','real','double'
     $     ,'quad'
      print *, huge(0), huge(0e0), huge(0d0), huge(0q0)
      print *, 1, tiny(0e0), tiny(0d0), tiny(0q0)
      end program extrema
