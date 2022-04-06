 1    program units
      implicit none

      include "metrics_revised2.inc"
      integer dummy,comp_real_str,comp_real
      real(kind = set_kind), parameter :: dB_yd2m=20d0*log10(m2ft/3q0)
      character(len = 256) :: fmt3,fmt2
      character (len=40) str_m2ft,str_m2mi,str_dB_m2yd,str_ms2kt
     &     ,str_kt2ms

c     equivalence definitions
      integer, parameter :: ift2m=3048
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
      integer, parameter :: dp = 33
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk) qnmi2m,qft2m,qm2ft,m2nmi,m2yd,yd2m,qdB_m2yd
     &     ,qdB_yd2m,qkt2ms,qms2kt,qans
      character(len = 256) :: fmt
      real(kind = 4) snmi2m,sm2nmi,sft2m,sm2ft,sm2yd,syd2m,sdB_m2yd
     &     ,sdB_yd2m,sms2kt,skt2ms,sans
      real(kind = 8) dnmi2m,dm2nmi,dft2m,dm2ft,dm2yd,dyd2m,ddB_m2yd
     &     ,ddB_yd2m,dkt2ms,dms2kt,dans
      integer pdp
      
c     ----------------
c     REAL
c     ----------------      
      
      write(*,*)'unformatted'
      write(*,*) '   ft2m = ',ft2m    
      write(*,*) '   mi2m = ',mi2m    
      write(*,*) '   m2ft = ',m2ft   
      write(*,*) '   m2mi = ',m2mi    
      write(*,*) 'dB_m2yd = ',dB_m2yd 
      write(*,*) '  kt2ms = ',kt2ms   
      write(*,*) ' ms2kt  = ',ms2kt    
      
      write(*,*) ' prec ft2m    = ',precision(ft2m)
      write(*,*) ' prec mi2m    = ',precision(mi2m)
      write(*,*) ' prec m2ft    = ',precision(m2ft)
      write(*,*) ' prec m2mi    = ',precision(m2mi)
      write(*,*) ' prec dB_m2yd = ',precision(dB_m2yd)
      write(*,*) ' prec kt2ms   = ',precision(kt2ms)
      write(*,*) ' prec ms2kt   = ',precision(ms2kt)

      dummy=comp_real(abs(dB_m2yd),abs(dB_yd2m))
      
c     ----------------
c     SINGLE PRECISION
c     ----------------
      write(*,*)
      write(*,*)'single precision'
      pdp=precision(sft2m)
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
c     equivalence definitions
      sft2m=3048e-4
      snmi2m=1852e0
c     functional definitions
      sm2ft=1e0/sft2m
      sm2yd=sm2ft/3e0
      syd2m=1e0/sm2yd
      sdB_m2yd=20e0*log10(sm2yd)
      sdB_yd2m=20e0*log10(syd2m)
      
      sm2nmi=1e0/snmi2m
      sms2kt=sm2nmi*6e1*6e1
      skt2ms=1e0/sms2kt
      
c     printed output
      write(*,fmt)'   ft2m = ',sft2m
      write(*,fmt)'   m2ft = ',sm2ft
      write(*,fmt)'   m2yd = ',sm2yd
      write(*,fmt)'   yd2m = ',syd2m
      write(*,fmt)'dB_m2yd = ',sdB_m2yd
      write(*,fmt)'dB_yd2m = ',sdB_yd2m
      
      write(*,*  )' nmi2m = ',snmi2m
      write(*,*  )' m2nmi = ',sm2nmi
      write(*,fmt)'  kt2ms = ',skt2ms
      write(*,fmt)'  ms2kt = ',sms2kt

      write(*,*) 'kind ', kind(sdB_m2yd)
      write(*,*) 'precision ',precision(sdB_m2yd)

      dummy=comp_real(real(abs(sdB_m2yd),16),real(abs(sdB_yd2m),16))     
      
c     check differnece
      write(*,*)
      write(*,*) 'real error (write)'
      write(*,fmt)'   ft2m  - ft2m    = ',   sft2m - ft2m
      write(*,fmt)'   m2ft  - m2ft    = ',   sm2ft - m2ft
      write(*,fmt)'dB_yd2m  - dB_m2yd = ',sdB_yd2m - dB_m2yd
      write(*,fmt)'   nmi2m - nmi2m   = ',  snmi2m - mi2m
      write(*,fmt)'   m2nmi - m2mi    = ',   sm2nmi - m2mi
      write(*,fmt)'   kt2ms - kt2ms   = ',  skt2ms - kt2ms   
      write(*,fmt)'   ms2kt - ms2kt   = ',  sms2kt - ms2kt
      
      write(*,*)
      write(*,*) 'single error'
      sans = sft2m - ft2m
      write(*,fmt)'   ft2m  - ft2m    = ',   sans
      sans = sm2ft - m2ft
      write(*,fmt)'   m2ft  - m2ft    = ',   sans
      sans = sdB_yd2m - dB_m2yd
      write(*,fmt)'dB_yd2m  - dB_m2yd = ',sans
      sans = snmi2m - mi2m
      write(*,fmt)'   nmi2m - nmi2m   = ',  sans
      sans = sm2nmi - m2mi
      write(*,fmt)'   m2nmi - m2mi    = ',   sans
      sans = skt2ms - kt2ms   
      write(*,fmt)'   kt2ms - kt2ms   = ',  sans   
      sans = sms2kt - ms2kt
      write(*,fmt)'   ms2kt - ms2kt   = ',  sans

c      dummy=comp_real(m2ft,sm2ft)
c      dummy=comp_real(m2mi,sm2nmi)
c      dummy=comp_real(abs(dB_m2yd),abs(sdB_m2yd))
c      dummy=comp_real(abs(dB_yd2m),abs(sdB_yd2m))
c      dummy=comp_real(ms2kt,sms2kt)
c      dummy=comp_real(kt2ms,skt2ms) 

      
c     ----------------
c     DOUBLE PRECISION
c     ----------------      
      write(*,*)
      write(*,*)'double precision'
      pdp=precision(dft2m)      ! last decimal not consistent
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
c     equivalence definitions
      dft2m=3048d-4
      dnmi2m=1852d0
c     functional definitions
      dm2ft=1d0/dft2m
      dm2yd=dm2ft/3d0
      dyd2m=1d0/dm2yd
      ddB_m2yd=20d0*log10(dm2yd)
      ddB_yd2m=20d0*log10(dyd2m)
      
      dm2nmi=1d0/dnmi2m
      dms2kt=dm2nmi*6d1*6d1
      dkt2ms=1d0/dms2kt
      
c     printed output
      write(*,fmt)'   ft2m = ',dft2m
      write(*,fmt)'   m2ft = ',dm2ft
      write(*,fmt)'   m2yd = ',dm2yd
      write(*,fmt)'   yd2m = ',dyd2m
      write(*,fmt)'dB_m2yd = ',ddB_m2yd
      write(*,fmt)'dB_yd2m = ',ddB_yd2m
      
      write(*,*  )' m2nmi = ',dm2nmi
      write(*,fmt)'  kt2ms = ',dkt2ms
      write(*,fmt)'  ms2kt = ',dms2kt      
      
      write(*,*)
      write(*,*) 'double error'
      dans = dft2m - ft2m
      write(*,fmt)'   ft2m  - ft2m    = ',   dans
      dans = dm2ft - m2ft
      write(*,fmt)'   m2ft  - m2ft    = ',   dans
      dans = ddB_yd2m - dB_m2yd
      write(*,fmt)'dB_yd2m  - dB_m2yd = ',dans
      dans = dnmi2m - mi2m
      write(*,fmt)'   nmi2m - nmi2m   = ',  dans
      dans = dm2nmi - m2mi
      write(*,fmt)'   m2nmi - m2mi    = ',   dans
      dans = dkt2ms - kt2ms   
      write(*,fmt)'   kt2ms - kt2ms   = ',  dans   
      dans = dms2kt - ms2kt
      write(*,fmt)'   ms2kt - ms2kt   = ',  dans

c      dummy=comp_real(m2ft,dm2ft)
c      dummy=comp_real(m2mi,dm2nmi)
c      dummy=comp_real(abs(dB_m2yd),abs(ddB_m2yd))
c      dummy=comp_real(abs(dB_yd2m),abs(ddB_yd2m))
c      dummy=comp_real(ms2kt,dms2kt)
c      dummy=comp_real(kt2ms,dkt2ms) 

c      dummy=comp_real(abs(ddB_m2yd),abs(ddB_yd2m))

c     --------------
c     QUAD PRECISION
c     --------------      
      write(*,*)
      if(srk.ge.16) then
         write(*,*)'quad precision'
         pdp=precision(qft2m)-1
         qft2m=3048q-4          ! works for real*16, not real*10
      else if(srk.eq.10) then
         write(*,*)'extended precision'
         pdp=precision(qft2m)
         qft2m=ift2m            ! must copy integer value first for ultimate precision
         qft2m=qft2m/1q4        ! works
      else
         write(*,*)'specified precision'
         pdp=dp
c        qft2m=3048q-4
         qft2m=ift2m            ! must copy integer value first for ultimate precision
         qft2m=qft2m/1q4        ! works
      endif

c     formatting
      write(fmt,'(a,i02,a)')'(a,i',ceiling(log10(real(pdp))),')'
      write(*,fmt)'decimal places = ',pdp
      write(*,fmt)'real bytes = ',srk
      
c     equivalence definitions
      qnmi2m=1852q0

c     functional definitions
      m2nmi=1q0/qnmi2m
      qms2kt=m2nmi*6q1*6q1
      qkt2ms=1q0/qms2kt
      
c     printed output
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp-3,')'
c     write(fmt,'(a,i0.2,a,i0.2,a)')'(a,e',pdp+7,'.',pdp,')'
      write(*,fmt)'  nmi2m = ',qnmi2m

      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
c     write(fmt,'(a,i0.2,a,i0.2,a)')'(a,e',pdp+7,'.',pdp,')'
      write(*,fmt)'  m2nmi = ',m2nmi
      write(*,fmt)'  kt2ms = ',qkt2ms
      write(*,fmt)'  ms2kt = ',qms2kt
      write(*,*)
      
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'

c     functional definitions
      qm2ft=1q0/qft2m
      m2yd=qm2ft/3q0
      yd2m=1q0/m2yd
      qdB_m2yd=20q0*log10(m2yd)
      qdB_yd2m=20q0*log10(yd2m)
      
c     printed output
      write(*,fmt)'   ft2m = ',qft2m
      write(*,fmt)'   m2ft = ',qm2ft
      write(*,fmt)'   m2yd = ',m2yd
      write(*,fmt)'   yd2m = ',yd2m
      write(*,fmt)'dB_m2yd = ',qdB_m2yd
      write(*,fmt)'dB_yd2m = ',qdB_yd2m


      dummy=comp_real(abs(qdB_m2yd),abs(qdB_yd2m))
      
      write(*,'(a,i2)')'   set precision is ',set_precision      
      pdp=precision(ft2m)
      write(*,'(a,i2)')'actual precision is ',pdp
      write(fmt3,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
      write(fmt2,'(a,i0.2,a,i0.2,a)')'(a,es',pdp+3+4,'.',pdp,')'
      write(*,*)'fmt3 = ',trim(fmt3)
      write(*,*)'fmt2 = ',trim(fmt2)

      write(*,fmt3)'   ft2m = ',ft2m
      write(*,fmt3)'   m2ft = ',m2ft
      write(*,fmt2)'   mi2m = ',mi2m

      write(*,fmt3)'   ft2m = ',ft2m
      write(*,fmt3)'   m2ft = ',m2ft
      write(*,fmt2)'   mi2m = ',mi2m
      write(*,fmt2)'   m2mi = ',m2mi    
      write(*,fmt3)'dB_m2yd = ',dB_m2yd
      write(*,fmt3)'dB_yd2m = ',dB_yd2m
      write(*,fmt3)'  kt2ms = ',kt2ms
      write(*,fmt3)'  ms2kt = ',ms2kt  

      dummy=comp_real(m2ft,qm2ft)
      dummy=comp_real(m2mi,m2nmi)
      dummy=comp_real(abs(dB_m2yd),abs(qdB_m2yd))
      dummy=comp_real(abs(dB_yd2m),abs(qdB_yd2m))
      dummy=comp_real(ms2kt,qms2kt)
      dummy=comp_real(kt2ms,qkt2ms) 

c     test functional definitions against strings

c                 1234567890123456789012345678901234567890
      str_m2ft   ='3.28083989501312335958005249343832020997'
      str_m2mi  ='0.00053995680345572354211663066954643628'
      str_dB_m2yd='0.77727565225549351043480174978008085437' 
      str_ms2kt  ='1.94384449244060475161987041036717062634'
      str_kt2ms  ='0.51444444444444444444444444444444444444'

      dummy=comp_real_str(m2ft,str_m2ft)
      dummy=comp_real_str(m2mi,str_m2mi)
      dummy=comp_real_str(abs(dB_m2yd),str_dB_m2yd)
      dummy=comp_real_str(ms2kt,str_ms2kt)
      dummy=comp_real_str(kt2ms,str_kt2ms)

      dummy=comp_real(real(100,16),real(100,16))
      
      end

      integer function comp_real_str(real_val,str_ref)
      implicit none
      integer(kind=16) i,i_dum,i_ref,i_test,ii
      real(kind=16) real_val
      character (len=40) str_ref      
      logical  val_ok

      write(*,*)log10(real_val)
      write(*,*)floor(log10(real_val))
      write(*,*)real_val*10**(-1q0*floor(log10(real_val)))

c     compare digits
      write(*,*)'comparing digits... (function)'
      ii=0
      val_ok=.true.
      write(*,'(a,f40.38)')'     test value is ',real_val
      write(*,'(a,a,a)')'reference value is ',str_ref,' (string)'
      i = index(str_ref,'.')
      write(*,*)'decimal point found at ',i
      
      do while (val_ok.and.(ii.lt.len(str_ref)))
         i_test=floor(real_val*10**ii,16)
         if (ii+1.lt.i) then
            read(str_ref(1:ii+1),*)i_ref
         else
            read(str_ref(1:i-1),*)i_dum
            i_ref=i_dum*10**ii
            read(str_ref(i+1:ii+2),*)i_dum
            i_ref=i_ref+i_dum
         endif
         write(*,*)ii+1,i_ref,i_test,i_ref.eq.i_test
         if ((i_ref.ne.i_test)) then
            val_ok=.false.
            write(*,'(1x,i2,a)')ii
     $           ,' decimal places of precision achieved'
            comp_real_str=ii
            return
         endif
         ii=ii+1
      enddo
      end

      integer function comp_real(real_val,real_ref)
      implicit none
c      integer,parameter :: ln1=precision(real_val)
c      integer,parameter :: ln2=precision(real_ref)
      integer(kind=16) i_ref,i_test,ii,a,pdp
      real(kind=16) real_val,real_ref,b,sci_val,sci_ref
      logical  val_ok
      character(len=40) fmt

c     convert to scientific notation
      write(*,*)'convert digits...'
      write(*,*)log10(real_val)
      write(*,*)floor(log10(real_val))
      write(*,*)real_val*10**(-1q0*floor(log10(real_val)))

      a=floor(log10(real_val))
      write(*,*)'a = ',a      
      b=10**(-1q0*a)
      write(*,*)'b = ',b

      write(*,*)'test real_val = ',real_val*b
      write(*,*)'test real_ref = ',real_ref*b
      
      sci_val=real_val*b
      write(*,*)'here'
      sci_ref=real_ref*b

      write(*,*)'test real_val = ',sci_val
      write(*,*)'test real_ref = ',sci_ref

      pdp=precision(real_val)

c     print digits
      if(a.gt.0) then
         write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+2,'.',pdp-a,')'
      else
         write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+2,'.',pdp,')'
         endif
      write(*,*)fmt
      write(*,fmt)'     test value is ',real_val
      write(*,fmt)'reference value is ',real_ref
      write(*,*)'test precision = ',pdp
      write(*,*)' ref precision = ',precision(real_ref)
      write(*,*)'test kind = ',kind(real_val)
      write(*,*)' ref kind = ',kind(real_ref)           
      
c     compare digits
      write(*,*)'comparing digits... (function)'
      ii=0
      val_ok=.true.      
      do while (val_ok.and.(ii.lt.precision(real_ref)))
         i_test=floor(sci_val*10**ii,16)
         i_ref=floor(sci_ref*10**ii,16)
         
         write(*,*)ii+1,i_ref,i_test,i_ref.eq.i_test
         if ((i_ref.ne.i_test)) then
            val_ok=.false.
            write(*,'(1x,i2,a)')ii
     $           ,' decimal places of precision achieved'
            comp_real=ii
            return
         endif
         ii=ii+1
      enddo
      if(val_ok) then
         comp_real=precision(real_ref)
      endif
      write(*,*)ii
      if(ii.eq.precision(real_ref))then
         write(*,*)'yes'
      else
         write(*,*)'no'
      endif
      end
