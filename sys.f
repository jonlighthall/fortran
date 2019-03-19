      program sys
      character(256) sfx, cmd
      character(len=1024) :: filename
      character(len=1024) :: fmt
      integer cg_itr
      print *, "system command test"
c     base file name
      sfx = 'nspe.in'
      write(*,*) 'input file name is', sfx, len_trim(sfx)
      do 10 i=0,2,1 
         cg_itr=i
c     for each iteration, copy the input file with unique name
         write(cmd,'(3a,i0.3,a)')'cp ',trim(sfx),' nspe',cg_itr
     &        ,'.in'
         write(*,*) 'command is', cmd
         call system(cmd)
 10   continue
c     test variable format
      do i=1, 10
         if (i < 10) then
            fmt = "(A,I1)"
         else
            fmt = "(A,I2)"
         endif
c         fmt = '(a,i0.2)'
         write (filename,fmt) "sys", i
         print *, trim(filename)
      enddo
      end program sys
