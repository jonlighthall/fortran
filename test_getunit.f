      program test_getunit
      implicit none
      integer lun,newunit
      integer unit1,unit2,unit3,unit4
      
      open(newunit(lun),file='test')
      open(newunit(unit1),file='test1')
      open(newunit(unit2),file='test2')
      open(newunit(unit3),file='test3')
      open(newunit(unit4),file='test4')

      close(lun)
      close(unit1)
      close(unit2)
      close(unit3)
      close(unit4)

      end program test_getunit
