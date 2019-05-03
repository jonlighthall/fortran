      program collatz
      implicit none
      integer*16 n,i
      write(*,*)'enter arbitrary positive integer'
      read *,n
      in(n)
      end

      integer*16 function in(n)
      implicit none
      integer*16 n,in,seq
c      write(*,*)'received input ',n
      in=0
      do while (n.gt.1)
c     write(*,*)'in = ',i,n
         n=seq(n)
         in=in+1
      enddo
      write(*,*)'in = ',in
      return
      end

      integer*16 function seq(n)
      implicit none
      integer*16 n,nmax
      nmax=42                   ! 1 bit
      nmax=10922                ! 2 bit
      nmax=715827882            ! 4 bit
      nmax=3074457345618258602  ! 8 bit
      nmax=56713727820156410577229101238628035242 ! 16 bit
      if (mod(n,2).eq.0) then
         seq=n/2
      else
         if(n.gt.nmax) then
            write(*,*)'ERROR: Overflow imminent.'
            write(*,*)'Maximum hailstone size exceeded',n,3*n+1
            seq=1
         else
            seq=3*n+1
         endif
      endif
      return
      end
