      program basel
      implicit none
      integer (kind=16) i,pdp,j,k,l,step,n
      INTEGER(kind=4) :: count,count_rate,count_max,delay,elap
      logical ext
c     set decimal point precision
c
c     for each real kind, the maximum number of decimal places is given
c     along with the maximum accurate (consistent) decimal place
c      
c     bytes max consistent
c     ----- --- ---------
c      4     6   6
c      8    15  14
c     10    18  14
c     16    33  32
      integer, parameter :: dp = 7
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk), parameter :: pi = 4.d0*atan(1.d0)
      real(kind = srk) sum,pival,seq,pireal
      character (len=40) pistr,fmt,unit_name,host
      CALL SYSTEM_CLOCK(count, count_rate, count_max)
      if(count_rate.eq.1000) then
         write(unit_name,*) 'miliseconds'
      else
         write(unit_name,*) 'units'
      endif
      write(*,'(1x,i2,a,i2,a)')dp,' decimals in ',srk,' bytes'
      pdp=dp+1
      write(fmt,'(a,i0.2,a,i0.2,a)')'(3x,f',pdp+2,'.',pdp,',a)'
      pistr = '3.1415926535897932384626433832795028841971693993751058'
      write(*,'(3x,2a)')trim(pistr(1:dp+2)),' string'
      read(pistr,*)pireal
      write(*,fmt)pireal,'  real'
      write(*,fmt)pi,'  atan'

c     estimate number of steps
      n=sqrt(1/epsilon(seq))
      write(*,*) 'n = ',sqrt(1/epsilon(seq))
      write(*,*) 'n = ',n
      
c     calculate series
      sum=0
      i=1
      pival=0
      seq=2
      step=n/10
      write(*,*) 'step = ',step
      write(*,*)
      write(*,fmt,advance='no')pival
      write(*,'(3x,g16.10)',advance='no')seq
      
      do while ((seq.gt.1q0/(i*i)).and.(i.lt.n)) ! ensure that squence in monotonically decreasing
         seq=1q0/(i*i)       
         sum=sum + seq
         pival=sqrt(6q0*sum)
c     print progress
         if(mod(i,step).eq.0) then
            write(*,*)
            write(*,fmt,advance='no')pival
            write(*,'(3x,g16.10)',advance='no')seq
         endif
         if(mod(i,step/10).eq.0) write(*,'(a)',advance='no')'.'

c         if(i.lt.n) write(*,*) 'end: i = ',i
         
         i=i+1
      enddo
      write(*,*)
      write(*,fmt)pival,'  Basel'
      write(*,*)i,sum,pival

c     compare digits
      do i=0,dp+1
         sum=pireal*10**i
         j=floor(sum)
         sum=pi*10**i
         k=floor(sum)
         sum=pival*10**i
         l=floor(sum)
         write(*,*)i+1,j,k,l,j.eq.k,j.eq.l
         if (j.ne.l) exit
      enddo
      write(*,'(1x,i2,a)')i,' decimal places of precision achieved'

c     calcualte elapsed time
      call system_clock(delay)
      if(delay.lt.count) then
         write(*,*)'rollover suspected'
         elap=(delay+count_max-count)
      else
         elap=(delay-count)
      endif
      call hostnm(host)
      write(*,*)'Elapsed time is ',elap,' ',trim(unit_name),' on ',host

c     write to file
      inquire(file = '/Acoustics/forjon/fortran/basel_time.txt',exist
     $     =ext)
      if(ext) then
         open(1,file = '/Acoustics/forjon/fortran/basel_time.txt',status
     &        ='old',position='append',action='write')
         write(1,*)'Elapsed time is ',elap,' on ',host
         close(1)
      endif
      end
