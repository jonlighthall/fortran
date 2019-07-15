!     This is a simple function to search for an available unit. LUN_MIN
!     and LUN_MAX define the range of possible LUNs to check. The UNIT
!     value is returned by the function, and also by the optional
!     argument. This allows the function to be used directly in an OPEN
!     statement, and optionally save the result in a local variable. 
!     If no units are available, -1 is returned.
      integer function newunit(unit)
      integer, intent(out), optional :: unit
!     local
      integer, parameter :: LUN_MIN=1, LUN_MAX=30
      logical :: opened
      integer :: lun
!     begin
      newunit=-1
      write(*,'(2(a,i2))')'testing units ',LUN_MIN,' to ',LUN_MAX
      do lun=LUN_MIN,LUN_MAX
         write(*, '(A,i2)', ADVANCE = "NO")'testing ',lun
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
