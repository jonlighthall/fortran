      program test_getunit
      implicit none
      integer getunit
      integer unit1,unit2,unit3,unit4
      write(*,'(a)') "hello, world"

      unit1=getunit()

      open(unit1,file='test1')
      unit2=getunit()
      open(unit2,file='test2')
      unit3=getunit()

      open(unit3,file='test3')
      unit4=getunit()
      open(unit4,file='test4')

      close(unit1)
      close(unit2)
      close(unit3)
      close(unit4)

      end program test_getunit

      integer function getunit()
      implicit none
      integer lun
      logical i_open
      getunit = -1
      do lun=1,64
         write(*, '(a,i2,a)', advance = "no")' testing ',lun,'...'
         inquire(unit=lun,opened=i_open)
         if (.not. i_open) then
            getunit = lun
            write(*,*)"available"
            exit
         else
            write(*,*)'not available'
         end if
      end do
      end function getunit
