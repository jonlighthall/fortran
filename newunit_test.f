      program test_program
      integer lun
      integer unit1,unit2,unit3
      open(unit=newunit(lun),file='test')
      unit1=newunit(lun)
      open(unit1,file='test1')
      unit2=newunit(lun)
      open(unit2,file='test2')
      unit3=newunit(lun)
      open(unit3,file='test3')
      end program test_program
