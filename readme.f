c     NB: column numbers start from 1.

c     {----------------------------------------------------------------}
c     FORTRAN 72-column line length
c     Use the Fortran dialect compiler option -ffixed-form or use the
c     file extension .f.
c     ...1....,....2....,....3....,....4....,....5....,....6....,....7..
c     789012345678901234567890123456789012345678901234567890123456789012
c     {----------------------------------------------------------------}
c     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
c     eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
c     enim ad minim veniam, quis nostrud exercitation ullamco laboris
c     nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
c     reprehenderit in voluptate velit esse cillum dolore eu fugiat
c     nulla pariatur. Excepteur sint occaecat cupidatat non proident,
c     sunt in culpa qui officia deserunt mollit anim id est laborum.
c     {----------------------------------------------------------------}

      program readme
      implicit none
      character(len=100) :: filename
      character(len=100) :: line
      integer ierr

      ! Set the file name using a variable
      filename = "example.txt"

      ! Open the file for reading
      open(unit=10, file=trim(filename), status='old', action='read')

      ! Read and print each line of the file
      do while (.true.)
       read(10, '(A)', iostat=ierr) line
       if (ierr /= 0) exit
       write(*, '(A)') trim(line)
      end do

      ! Close the file
      close(10)

      end