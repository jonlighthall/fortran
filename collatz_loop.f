      program collatz_loop
      implicit none
      integer*2 i,j,k,n,nmax,maxdelay,delay_record,seed,delay
      i=1 
      j=0
      do while (i.gt.j)
         j=i
         i=i*2
      enddo
      do k=floor(log10(real(j))),0,-1
         i=j
         j=i-1
         do while (i.gt.j)
            j=i
            i=i+10**k
         enddo
      enddo
      write(*,*) '          the largest integer is', j
      nmax=(j-1)/3
      write(*,*) 'the largest hailstone integer is', nmax
      maxdelay=0
      delay_record=0
      do seed=0,nmax
         n=seed
         delay=0
         do while (n.gt.1)
            if (mod(n,2).eq.0) then
               n=n/2
            else
               if(n.gt.nmax) then
                  write(*,*)'ERROR ',n,delay,seed
                  n=1
               else
                  n=3*n+1
               endif
            endif
            delay=delay+1
         enddo
         if (delay>maxdelay) then
            delay_record=delay_record+1
            write(*,*)'max = ',delay_record,delay,seed
            maxdelay=delay
         endif
      enddo
      end
