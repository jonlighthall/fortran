      subroutine format(int,str)
      implicit none
      integer,intent(in)::int
      character(64), intent(out)::str
      character(64) copy
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
            str(pos2+div:)=','
            pos2=pos2+1
         endif
         pos2=pos2+div
      enddo
      return
      end
