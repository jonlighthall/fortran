      program ask
      logical ans,yea
      character words
      ans=.false.
      write(*,*)'give me an answer (y/n)'
      read(5,*)words
      write(*,*)words
      
      if(index('yY',words).gt.0) then
         ans=.true.
      else
         ans=.false.
      endif
      write(*,*)ans

c     check response with function
      ans=yea(words)
      write(*,*)ans
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
