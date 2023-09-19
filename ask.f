      program ask
      implicit none
      interface
         logical function yea(text)
         character text
         end function
      end interface
      logical answer
      character response
      answer=.false.
      write(*,*)'give me an answer (y/n)'
      read(5,*)response
      write(*,*)'Your answer was "',response,'"'
      if(index('yY',response).gt.0) then
         answer=.true.
      else
         answer=.false.
      endif
      write(*,*)'Conditional assignment = ',answer

c     check response with function
      answer=yea(response)
      write(*,*)' Functional assignment = ',answer
      end

c     check if response is positive
      logical function yea(text)
      character text
      if(index('yY',text).gt.0) then
         yea=.true.
      else
         yea=.false.
      endif
      return
      end

