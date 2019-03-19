      program hello
      character(256) sfx, sysstr
      character(len=1024) :: filename
      character(len=1024) :: format_string
      integer cg_itr
c      integer system
      print *, "hello world"
      print *, "fortan"
      sfx = 'nspe.in'
      write(*,*) 'file name is', sfx, len_trim(sfx)
      
      do 10 i=0,2,1 !print beeps at end of program
         print *, " beep!", char(7)
         write(sysstr,'(a,i0.3)') trim(sfx), i
         cg_itr=i
c         write(sysstr,'(3xa,i0.3,a)')'cp ',trim(sfx),' nspe',cg_itr
         write(sysstr,'(3a,i0.3,a)')'cp ',trim(sfx),' nspe',cg_itr
	1     ,'.in'
         write(*,*) sysstr
         call system(sysstr)
c         call sleep(1)
 10   continue

      do i=1, 10
         if (i < 10) then
            format_string = "(A,I1)"
         else
            format_string = "(A5,I2)"
         endif

         write (filename,format_string) "hello", i
         print *, trim(filename)
      enddo
      end program hello
