      program ask
      implicit none
      interface
         logical function yea(text)
         character text
         end function
      end interface
      logical ans
      character words
      ans=.false.
      write(*,*)'give me an answer (y/n)'
      read(5,*)words
      write(*,*)'Your answer was "',words,'"'

      if(index('yY',words).gt.0) then
         ans=.true.
      else
         ans=.false.
      endif
      write(*,*)'Conditional assignment = ',ans

c     check response with function
      ans=yea(words)
      write(*,*)' Functional assignment = ',ans
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
