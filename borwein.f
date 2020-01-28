      program borwein
      real(16)a,b,p,sum
      integer(16) ii,i,j,l
      character (len=40) ipistr
      logical  valok
      a=sqrt(2d0)
      b=0d0
      p=2d0+sqrt(2d0)
       ipistr = '31415926535897932384626433832795028841971693993751058'
      do i=1,5
         b=((1d0+b)*sqrt(a))/(a+b)
         a=(sqrt(a)+1d0/sqrt(a))/2d0
         p=((1d0+a)*p*b)/(1d0+b)
         write(*,*)i,a,b,p

         ii=0
         valok=.true.
         do while (valok)
            sum=p*10**ii
            j=floor(sum,16)
            read(ipistr(1:ii+1),*)l
            write(*,*)ii+1,j,l,j.eq.l
            if ((j.ne.l)) then
               valok=.false.
               exit
            endif
            ii=ii+1
         enddo
         
      enddo
      end 
