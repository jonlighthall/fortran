      program test_program
      integer lun
      integer unit1,unit2,unit3,unit4
      
      open(unit=newunit(lun),file='test')
      open(unit=newunit(unit1),file='test1')
      open(unit=newunit(unit2),file='test2')
      open(unit=newunit(unit3),file='test3')
      open(unit=newunit(unit4),file='test4')

      close(lun)
      close(unit1)
      close(unit2)
      close(unit3)
      close(unit4)
      
      end program test_program
