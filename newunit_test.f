      program test_program
      integer lun
      integer unit1,unit2,unit3
      open(unit=newunit(lun),file='test')
      write(*,*) 'lun = ', lun
c     unit1=newunit(lun)
c     open(unit1,file='test1')
      open(unit=newunit(unit1),file='test1')
      write(*,*) 'unit1 = ', unit1
c     unit2=newunit(lun)
c     open(unit2,file='test2')
      open(unit=newunit(unit2),file='test2')
      write(*,*) 'unit2 = ', unit2
c     unit3=newunit(lun)
c     open(unit3,file='test3')
      open(unit=newunit(unit3),file='test3')
      write(*,*) 'unit3 = ', unit3
      close(lun)
      close(unit1)
      close(unit2)
      close(unit3)

      end program test_program
