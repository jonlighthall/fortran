c     This is a replacement for the Fortran 2008 function NEWUNIT for
c     systems running gfortran versions < 4.5
c
c     replace open(newunit=unit) with open(newunit(unit))
c
!     This is a simple function to search for an available unit. lun_min
!     and lun_max define the range of possible luns to check. The unit
!     value is returned by the function, and also by the optional
!     argument. This allows the function to be used directly in an open
!     statement, and optionally save the result in a local variable. 
!     If no units are available, -1 is returned.
      integer function newunit(unit)
      integer, intent(out), optional :: unit
!     local
      integer, parameter :: lun_min=1, lun_max=30
      logical :: opened
      integer :: lun
!     begin
      newunit=-1
      write(*,'(2(a,i2))')'testing units ',lun_min,' to ',lun_max
      do lun=lun_min,lun_max
         write(*, '(a,i2,a)', advance = "no")'testing ',lun,'...'
         inquire(unit=lun,opened=opened)
         if (.not. opened) then
            newunit=lun
            write(*,*)"available"
            exit
         else
            write(*,*)'not available'
         end if
      end do
      if (present(unit)) unit=newunit
      end function newunit
