! NB: column numbers start from 1.

! ----------------------------------------------------------------------------------------------------------------------------------
! Fortran 90 free form 132
! Use the Fortran dialect compiler option -ffree-form or use the file extension .f90.
! ..,....+....,....+....,....+....,....+....,....+....,....+....,....+....,....+....,....+....,....1....,....+....,....+....,....+..
! ..,....1....,....2....,....3....,....4....,....5....,....6....,....7....,....8....,....9....,....0....,....1....,....2....,....3..
! 3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
! ----------------------------------------------------------------------------------------------------------------------------------
! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
! enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
! reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt
! in culpa qui officia deserunt mollit anim id est laborum.
! ----------------------------------------------------------------------------------------------------------------------------------

! -----------------------------------------------------------------------------------------------
! Fortran 90, 97 columns
! Use the Fortran dialect compiler option -ffree-line-length-97
! -------------------Emacs PostScript "pretty-print" page width (97 columns)---------------------
! ..,....1....,....2....,....3....,....4....,....5....,....6....,....7....,....8....,....9....,..
! 34567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
! -----------------------------------------------------------------------------------------------
! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
! labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
! laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
! voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
! non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
! -----------------------------------------------------------------------------------------------

! ------------------------------------------------------------------------------
! Fortran 90, 80-column punch card
! Use the Fortran dialect compiler option -ffree-line-length-80
! ..,....1....,....2....,....3....,....4....,....5....,....6....,....7....,....8
! 345678901234567890123456789012345678901234567890123456789012345678901234567890
! ------------------------------------------------------------------------------
! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
! incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
! nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
! consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
! cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
! proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
! ------------------------------------------------------------------------------

! ----------------------------------------------------------------------
! Fortran 90, 72-column line length
! Use the Fortran dialect compiler option -ffixed-form or use the file
! extension .f.
! ..,....1....,....2....,....3....,....4....,....5....,....6....,....7..
! 3456789012345678901234567890123456789012345678901234567890123456789012
! ----------------------------------------------------------------------
! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
! eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
! minim veniam, quis nostrud exercitation ullamco laboris nisi ut
! aliquip ex ea commodo consequat. Duis aute irure dolor in
! reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
! pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
! culpa qui officia deserunt mollit anim id est laborum.
! ----------------------------------------------------------------------

! stop print

program readme
  implicit none
  ! define I/O variables
  integer read_unit,ierr
  ! create variable to store file lines
  character(len=132) :: line
  ! define flag to stop printing file
  character(len=132), parameter :: flag='! stop print'
  ! define file name
  character(len=32), parameter :: fname='readme.f90'
  write(*,'(1x,3a)',advance='no')'opening ',trim(fname),'... '
  open(newunit=read_unit,file='readme.f90',iostat=ierr,status='old',action='read')
  if (ierr==0) then
     print*,'OK'
  else
     print*,'ERROR'
  endif
  do
     read(read_unit,'(a)',iostat=ierr) line
     if (ierr.ge.0) then
        if(index(line,flag).ne.0) then
           exit
        else
           print*,trim(line)
        endif
     else
        print'(/a)','EOF'
        exit
     endif
  enddo
  close(read_unit)
end program readme
