      program test_getunit
      implicit none
      interface
         integer function getunit(unit)
         integer, intent(out), optional :: unit
         end function getunit
      end interface
      integer lun
      integer unit1,unit2,unit3,unit4
      
      open(getunit(lun),file='test')
      open(getunit(unit1),file='test1')
      open(getunit(unit2),file='test2')
      open(getunit(unit3),file='test3')
      open(getunit(unit4),file='test4')

      close(lun)
      close(unit1)
      close(unit2)
      close(unit3)
      close(unit4)

      end program test_getunit
