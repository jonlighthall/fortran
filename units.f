      program units
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
c     4     6   6
c     8    15  14
c     10    18  14
c     16    33  32
      integer, parameter :: dp = 33
      integer, parameter :: func_kind = 16
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk) qnmi2m,qft2m,qm2ft,m2nmi,m2yd,yd2m,qdB_m2yd
     &     ,qdB_yd2m,qkt2ms,qms2kt,qans
      character(len = 256) :: fmt
      real(kind = 4) snmi2m,sm2nmi,sft2m,sm2ft,sm2yd,syd2m,sdB_m2yd
     &     ,sdB_yd2m,sms2kt,skt2ms,sans
      real(kind = 8) dnmi2m,dm2nmi,dft2m,dm2ft,dm2yd,dyd2m,ddB_m2yd
     &     ,ddB_yd2m,dkt2ms,dms2kt,dans
      integer pdp,spa,dpa,qpa,strpa
      
c     ----------------
c     REAL
c     ----------------      
      write(*,'(a,i2)')'set precision is ',set_precision
      write(*,'(a,i2)')'selected real kind is ',set_kind

      write(*,*)
      write(*,*)'unformatted'
      pdp=precision(ft2m)
      write(*,'(x1a,i2)') ' precision  = ',pdp
      write(*,*) '   ft2m = ',ft2m    
      write(*,*) '   mi2m = ',mi2m    
      write(*,*) '   m2ft = ',m2ft   
      write(*,*) '   m2mi = ',m2mi    
      write(*,*) 'dB_m2yd = ',dB_m2yd
      write(*,*) 'dB_yd2m = ',dB_yd2m 
      write(*,*) '  kt2ms = ',kt2ms   
      write(*,*) ' ms2kt  = ',ms2kt      
      dummy=comp_real(real(abs(dB_m2yd),func_kind),real(abs(dB_yd2m)
     &     ,func_kind))

      write(*,*)
      write(*,*)'formatted'
      write(*,'(a,i2)')'precision is ',pdp
      write(fmt3,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
      write(fmt2,'(a,i0.2,a,i0.2,a)')'(a,es',pdp+3+4,'.',pdp,')'
c     write(*,*)'fmt3 = ',trim(fmt3)
c     write(*,*)'fmt2 = ',trim(fmt2)

      write(*,fmt3)'   ft2m = ',ft2m
      write(*,fmt2)'   mi2m = ',mi2m
      write(*,fmt3)'   m2ft = ',m2ft
      write(*,fmt2)'   m2mi = ',m2mi    
      write(*,fmt3)'dB_m2yd = ',dB_m2yd
      write(*,fmt3)'dB_yd2m = ',dB_yd2m
      write(*,fmt3)'  kt2ms = ',kt2ms
      write(*,fmt3)'  ms2kt = ',ms2kt  
      
c     ----------------
c     SINGLE PRECISION
c     ----------------
      write(*,*)
      write(*,*)'single precision'
      pdp=precision(sft2m)
      write(*,'(x1a,i2)')'precision = ',pdp
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

      dummy=comp_real(real(abs(sdB_m2yd),func_kind),real(abs(sdB_yd2m)
     &     ,func_kind))     
      
c     check differnece
      write(*,*)
      write(*,*) 'single error (write)'
      write(*,fmt)'   ft2m  - ft2m    = ',   sft2m - ft2m
      write(*,fmt)'   m2ft  - m2ft    = ',   sm2ft - m2ft
      write(*,fmt)'dB_yd2m  - dB_m2yd = ',sdB_yd2m - dB_m2yd
      write(*,fmt)'   nmi2m - nmi2m   = ',  snmi2m - mi2m
      write(*,fmt)'   m2nmi - m2mi    = ',   sm2nmi - m2mi
      write(*,fmt)'   kt2ms - kt2ms   = ',  skt2ms - kt2ms   
      write(*,fmt)'   ms2kt - ms2kt   = ',  sms2kt - ms2kt
      
      write(*,*)
      write(*,*) 'single error (variable)'
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

      spa=0
      dummy=comp_real(real(m2ft,func_kind),real(sm2ft,func_kind))
      if(dummy.gt.spa)spa=dummy
      dummy=comp_real(real(m2mi,func_kind),real(sm2nmi,func_kind))
      if(dummy.lt.spa)spa=dummy
      dummy=comp_real(real(abs(dB_m2yd),func_kind),real(abs(sdB_m2yd)
     &     ,func_kind))
      if(dummy.lt.spa)spa=dummy
      dummy=comp_real(real(abs(dB_yd2m),func_kind),real(abs(sdB_yd2m)
     &     ,func_kind))
      if(dummy.lt.spa)spa=dummy
      dummy=comp_real(real(ms2kt,func_kind),real(sms2kt,func_kind))
      if(dummy.lt.spa)spa=dummy
      dummy=comp_real(real(kt2ms,func_kind),real(skt2ms,func_kind))
      if(dummy.lt.spa)spa=dummy
      write(*,'(a,i2)')'single precision acheived = ',spa
      
c     ----------------
c     DOUBLE PRECISION
c     ----------------      
      write(*,*)
      write(*,*)'double precision'
      pdp=precision(dft2m)      ! last decimal not consistent
      write(*,'(x1a,i2)')'precision = ',pdp
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

      dummy=comp_real(real(abs(ddB_m2yd),func_kind),real(abs(ddB_yd2m)
     &     ,func_kind))
      
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

      dpa=0
      dummy=comp_real(real(m2ft,func_kind),real(dm2ft,func_kind))
      if(dummy.gt.dpa)dpa=dummy
      dummy=comp_real(real(m2mi,func_kind),real(dm2nmi,func_kind))
      if(dummy.lt.dpa)dpa=dummy
      dummy=comp_real(real(abs(dB_m2yd),func_kind),real(abs(ddB_m2yd)
     &     ,func_kind))
      if(dummy.lt.dpa)dpa=dummy
      dummy=comp_real(real(abs(dB_yd2m),func_kind),real(abs(ddB_yd2m)
     &     ,func_kind))
      if(dummy.lt.dpa)dpa=dummy
      dummy=comp_real(real(ms2kt,func_kind),real(dms2kt,func_kind))
      if(dummy.lt.dpa)dpa=dummy
      dummy=comp_real(real(kt2ms,func_kind),real(dkt2ms,func_kind))
      if(dummy.lt.dpa)dpa=dummy
      write(*,'(a,i2)')'double precision acheived = ',dpa

c     --------------
c     QUAD PRECISION
c     --------------      
      write(*,*)
      if(srk.ge.16) then
         write(*,*)'quad precision'
         pdp=precision(qft2m)
         write(*,'(x1a,i2)')'precision = ',pdp
         qft2m=3048q-4          ! works for real*16, not real*10
      else if(srk.eq.10) then
         write(*,*)'extended precision'
         pdp=precision(qft2m)
         write(*,'(x1a,i2)')'precision = ',pdp
         qft2m=ift2m            ! must copy integer value first for ultimate precision
         qft2m=qft2m/1q4        ! works
      else
         write(*,*)'specified precision'
         pdp=dp
         write(*,'(x1a,i2)')'precision = ',pdp
c     qft2m=3048q-4
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

      dummy=comp_real(real(abs(qdB_m2yd),16),real(abs(qdB_yd2m),16))     

      qpa=0
      dummy=comp_real(real(m2ft,16),real(qm2ft,16))
      if(dummy.gt.qpa)qpa=dummy
      dummy=comp_real(real(m2mi,16),real(m2nmi,16))
      if(dummy.lt.qpa)qpa=dummy
      dummy=comp_real(real(abs(dB_m2yd),16),real(abs(qdB_m2yd),16))
      if(dummy.lt.qpa)qpa=dummy
      dummy=comp_real(real(abs(dB_yd2m),16),real(abs(qdB_yd2m),16))
      if(dummy.lt.qpa)qpa=dummy
      dummy=comp_real(real(ms2kt,16),real(qms2kt,16))
      if(dummy.lt.qpa)qpa=dummy
      dummy=comp_real(real(kt2ms,16),real(qkt2ms,16))
      if(dummy.lt.qpa)qpa=dummy
      write(*,'(a,i2)')'quad precision acheived = ',qpa

c     test functional definitions against strings
      write(*,*)
      write(*,*)'strings'
c     1234567890123456789012345678901234567890
      str_m2ft   ='3.28083989501312335958005249343832020997'
      str_m2mi  ='0.00053995680345572354211663066954643628'
      str_dB_m2yd='0.77727565225549351043480174978008085437' 
      str_ms2kt  ='1.94384449244060475161987041036717062634'
      str_kt2ms  ='0.51444444444444444444444444444444444444'

      strpa=0
      dummy=comp_real_str(real(m2ft,16),str_m2ft)
      if(dummy.gt.strpa)strpa=dummy
      dummy=comp_real_str(real(m2mi,16),str_m2mi)
      if(dummy.lt.strpa)strpa=dummy
      dummy=comp_real_str(real(abs(dB_m2yd),16),str_dB_m2yd)
      if(dummy.lt.strpa)strpa=dummy
      dummy=comp_real_str(real(ms2kt,16),str_ms2kt)
      if(dummy.lt.strpa)strpa=dummy
      dummy=comp_real_str(real(kt2ms,16),str_kt2ms)
      if(dummy.lt.strpa)strpa=dummy
      write(*,'(a,i2)')'precision acheived = ',strpa

      write(*,*)
      write(*,100)'precision: ',precision(ft2m)
      if(strpa.ge.set_precision) then
         write(*,100)'worked: ',strpa,' >= ',set_precision
      else
         write(*,100)'failed: ',strpa,' < ',set_precision
      endif
 100  format (x12(a,i2))
      end
      
      integer function comp_real_str(real_val,str_ref)
      implicit none
      integer(kind=16) i,i_dum,i_ref,i_test,ii,leading_zero
      real(kind=16) real_val
      character (len=40) str_ref      
      logical  val_ok
      integer,parameter :: db = 2
c     compare digits
      if(db>0) write(*,*)'comparing digits... (function)'
      ii=0
      leading_zero=0
      val_ok=.true.
      if(db>0) write(*,'(a,f40.38)')'     test value is ',real_val
      if(db>0) write(*,'(a,a,a)')'reference value is ',str_ref
     &     ,' (string)'
      i = index(str_ref,'.')
      if(db>1) write(*,*)'decimal point found at ',i
      
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
         if (i_ref.eq.0) leading_zero=leading_zero+1
         if(db>1) write(*,*)ii+1-leading_zero,i_ref,i_test
     &        ,i_ref.eq.i_test
         if ((i_ref.ne.i_test)) then
            val_ok=.false.
            comp_real_str=ii-leading_zero
            if(db>0) write(*,'(1x,i2,a)')comp_real_str
     $           ,' decimal places of precision achieved'
            return
         endif
         ii=ii+1
      enddo
      end

      integer function comp_real(real_val,real_ref)
      implicit none
      integer(kind=16) i_ref,i_test,ii,a,pdp
      real(kind=16) real_val,real_ref,b,sci_val,sci_ref
      logical  val_ok,found_sig
      character(len=40) fmt
      integer,parameter :: db=0
      if(db>0) write(*,*)'comparing digits...'
      pdp=precision(real_val)
c     convert to scientific notation
      a=floor(log10(real_val))
      b=10**(-1q0*a)
      sci_val=real_val*b
      sci_ref=real_ref*b

c     print digits
      if(a.gt.0) then
         write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+2,'.',pdp-a,')'
      else
         write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+2,'.',pdp,')'
      endif
      if(db>0) write(*,fmt)'     test value is ',real_val
      if(db>0) write(*,fmt)'reference value is ',real_ref
      
c     compare digits
      ii=0      
      val_ok=.true.      
      do while (val_ok.and.(ii.lt.precision(real_ref)))
         i_test=floor(sci_val*10**ii,16)
         i_ref=floor(sci_ref*10**ii,16)
         if(db>1) write(*,*)ii+1,i_ref,i_test,i_ref.eq.i_test
         if ((i_ref.ne.i_test)) then
            val_ok=.false.
            if(db>0) write(*,'(1x,i2,a)')ii
     &           ,' decimal places of precision achieved'
            comp_real=ii
            return
         endif
         ii=ii+1
      enddo
      if(val_ok) then
         comp_real=precision(real_ref)
      endif
      if(db>0) write(*,'(1x,i2,a)')ii
     &     ,' decimal places of precision confirmed'
      end
