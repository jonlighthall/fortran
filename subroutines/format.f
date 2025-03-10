      subroutine format(int,str)
      implicit none
      include 'set_format.f'
!     arguments
      integer(kind=intsize),intent(in)::int
      character(fmtsize), intent(out)::str
!     local
      character(len=*), parameter :: sep=',' ! divider
      character(fmtsize) copy
      integer, parameter :: div=3 ! divider spacing
      integer sln,pos,pos2,numdiv,numcom,i,spc
      write(copy,*)int          ! copy input
      copy=adjustl(copy)        ! shift left
      sln=len(trim(copy))       ! get string length
      numcom=(sln-1)/div        ! get number of commas
      numdiv=numcom+1           ! get number of divisions
      spc=numdiv*div-sln        ! get number of leading spaces
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
