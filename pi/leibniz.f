      program leibniz
      implicit none
      integer (kind=16) i,d,c,step,ii,ipi,test_val,j
      real (kind=8) r,p
      logical  val_ok
      integer :: count,count_rate,count_max,start,finish,elap
      include 'pi_string.f'
c     calculate series
      i=int(0,kind(i))
      r=0
      d=1
      step=1
      ii=0
c     initialize timer
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      start=count      
      do j=1,precision(p)
         do while (ii.lt.j)
            d=2*i+1
            c=int(-1,kind(c))**i
            r=r+real(c,kind(r))/real(d,kind(r))
            if((mod(i,step).eq.0).or.(j.eq.int(1,kind(j)))) then
               p=real(4,kind(p))*r
c     compare digits
               ii=j-int(1,kind(ii))
               val_ok=.true.
               do while (val_ok)
                  ipi=floor(p*10**real(ii,kind(p)),kind(ipi))
                  read(ipistr(int(1,kind(ii)):ii+int(1,kind(ii))),*)
     &                 test_val
                  if ((ipi.ne.test_val)) then
                     val_ok=.false.
                     exit
                  endif
                  ii=ii+int(1,kind(ii))
                  step=i
               enddo
            endif
            i=i+1
c     calculate elapsed time
            CALL SYSTEM_CLOCK(finish)
            if(finish.lt.start) then
               write(*,*)'rollover suspected'
               elap=(finish+count_max-start)
            else
               elap=(finish-start)
            endif           
c     if timer exceeded, exit
            if (elap.gt.5000) then
               exit
            endif            
         enddo
         write(*,'(2(i10,1x),sp,i2,ss,1x,2(f12.10,1x),i2)')i,d,c,r,p,ii
      enddo
      write(*,'(1x,i2,a)')ii,' decimal places of precision achieved'
      end
