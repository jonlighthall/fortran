      program fmt
      implicit none
      integer i,j,k
      character(64) dummy
      do j=0,6
         k=10**j
         write(*,*)repeat('-',10),k,repeat('-',10)
      do i =k-1,k+1
         write(*,'(i7)', advance = "no")i
         call format(i,dummy)
         write(*,*)dummy
      enddo
      enddo
      end

      subroutine format(int,str)
      implicit none
      integer,intent(in)::int
      character(64), intent(out)::str
      character(64) copy
      integer, parameter :: div=3 ! divider spacing
      integer sln,pos,pos2,numdiv,numcom,i,spc
      write(copy,*)int
c      write(copy,*)adjustl(copy)
      copy=adjustl(copy)
c      write(*,*)'"',copy,'"'
      sln=len(trim(adjustl(copy)))
c      write(*,*)'input is ',sln,' long'

c      numdiv=((sln-1)/div)+1
c      numcom=sln/div
      numcom=(sln-1)/div
      numdiv=numcom+1
      spc=numdiv*div-sln
c      write(*,*)'space = ',spc
      write(str,*)
      if (spc.gt.1) then
         write(spc,*)repeat(' ',spc)
      endif

      str(spc+1:sln+spc)=copy(1:sln)
c      write(*,*)'str = "',str,'"'
      copy=str
      write(str,*)
      pos=sln+1
      pos2=pos+numcom

c      write(*,'(5(a,i2))') 'numdiv = ',numdiv,', pos = ',pos
c     &     ,', pos2 = ',pos2,', numcom = ',numcom,', dif = ',numdiv
c     &     -numcom


      pos=1
      pos2=1     

       do i=1,numdiv
c$$$          write(*,*)'copy ',pos-div-1,':',pos,' to ',pos2-div-1,':',pos2
c$$$          pos=pos-div
c$$$          pos2=pos2-(div+1)
c          write(*,*)i,pos2,pos2+div-1,pos,pos+div-1
          str(pos2:pos2+div-1)=copy(pos:pos+div-1)
          pos=pos+div
          if(i.le.numcom) then
             str(pos2+div:)=','
             pos2=pos2+1
          endif
          pos2=pos2+div
      enddo
c      write(*,'(a/a)')copy,str
       return
      end
