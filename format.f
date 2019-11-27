      subroutine format(int,str)
      implicit none
      include 'set_format.f'
      integer(kind=intsize),intent(in)::int
c      integer,intent(in)::int
      character(len=*), parameter :: sep=','
      character(fmtsize), intent(out)::str
      character(fmtsize) copy
      integer, parameter :: div=3 ! divider spacing
      integer sln,pos,pos2,numdiv,numcom,i,spc
      write(copy,*)int
      copy=adjustl(copy)
      sln=len(trim(copy))       ! string length
      numcom=(sln-1)/div        ! number of commas
      numdiv=numcom+1           ! number of divisions
      spc=numdiv*div-sln        ! number of leading spaces
      write(str,*)
      str(spc+1:sln+spc)=copy(1:sln)
      copy=str
      pos=1
      pos2=1     

      do i=1,numdiv
         str(pos2:pos2+div-1)=copy(pos:pos+div-1)
         pos=pos+div
         if(i.le.numcom) then
            str(pos2+div:)=sep
            pos2=pos2+len(sep)
         endif
         pos2=pos2+div
      enddo
      return
      end
