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
      enddo
      enddo
      end

      subroutine format(int,str)
      implicit none
      integer,intent(in)::int
      character(64), intent(out)::str
      character(64) copy
      integer, parameter :: div=3 ! divider spacing
      integer sln,pos,pos2,numdiv,numcom,i
      write(copy,*)int
c      write(copy,*)adjustl(copy)
      copy=adjustl(copy)
      write(*,*)'"',copy,'"'
      sln=len(trim(adjustl(copy)))
      write(*,*)'input is ',sln,' long'

c      numdiv=((sln-1)/div)+1
c      numcom=sln/div
      numcom=(sln-1)/div
      numdiv=numcom+1
      pos=sln+1
      pos2=pos+numcom

      write(*,'(5(a,i2))') 'numdiv = ',numdiv,', pos = ',pos
     &     ,', pos2 = ',pos2,', numcom = ',numcom,', dif = ',numdiv
     &     -numcom
     

c$$$       do i=1,numdiv
c$$$          write(*,*)'copy ',pos-div-1,':',pos,' to ',pos2-div-1,':',pos2
c$$$          pos=pos-div
c$$$          pos2=pos2-(div+1)
c$$$
c$$$       enddo

       return
      end
