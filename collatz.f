      program collatz
      implicit none
      integer*16 n,i,seq
      write(*,*)'enter arbitrary positive integer'
      read *,n
      write(*,*)'received input ',n
      i=0
      do while (n.gt.1)
         write(*,*)'i = ',i,n
         n=seq(n)
         i=i+1
      enddo
      write(*,*)'i = ',i
      end

      integer*16 function seq(n)
      implicit none
      integer*16 n,seq,nmax
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
