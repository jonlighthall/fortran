      program borwein
      real(16)a,b,p
      a=sqrt(2d0)
      b=0d0
      p=2d0+sqrt(2d0)
      do i=1,5
         b=((1d0+b)*sqrt(a))/(a+b)
         a=(sqrt(a)+1d0/sqrt(a))/2d0
         p=((1d0+a)*p*b)/(1d0+b)
         write(*,*)i,a,b,p
      enddo
      end 
