      program ask
      logical ans
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
      end
