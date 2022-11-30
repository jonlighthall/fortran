      program units
      implicit none
      interface
         integer function comp_real(real_val,real_ref)
         implicit none
         real(kind=16),intent(in) :: real_val,real_ref
         end function comp_real


      integer function comp_real_str(real_val,str_ref)
      implicit none
      real(kind=16),intent(in) :: real_val
      character (len=40),intent(in) :: str_ref      
      end function comp_real_str

      subroutine report(acc,prec)
      implicit none
      integer,intent(in) :: acc,prec
      end subroutine report
      end interface

      include "metrics_revised2.inc"
      logical,parameter :: do_check=.false.
      integer dummy,pdp,spa,dpa,qpa,strpa
      real(kind = set_kind), parameter :: dB_yd2m=real(-20,set_kind)
     &     *log10(real(3,set_kind)
     &     *real(3048,set_kind)/real(10000,set_kind))
      character(len=56) :: fmt,fmt2,fmt3,str_m2ft,str_m2mi,str_dB_m2yd
     &     ,str_ms2kt,str_kt2ms

c     equivalence definitions
c     for each real kind, the maximum number of decimal places is given
c     along with the maximum accurate (consistent) decimal place
c     
c     bytes max consistent
c     ----- --- ---------
c     4     6   6
c     8    15  14
c     10    18  14
c     16    33  32
      integer, parameter :: dp = 33 ! number of decimal places
      integer, parameter :: srk = selected_real_kind(dp)
      real(kind = srk) qnmi2m,qft2m,qm2ft,qm2nmi,qm2yd,qyd2m,qdB_m2yd
     &     ,qdB_yd2m,qkt2ms,qms2kt
      real(kind = 4  ) snmi2m,sm2nmi,sft2m,sm2ft,sm2yd,syd2m,sdB_m2yd
     &     ,sdB_yd2m,sms2kt,skt2ms,sans
      real(kind = 8  ) dnmi2m,dm2nmi,dft2m,dm2ft,dm2yd,dyd2m,ddB_m2yd
     &     ,ddB_yd2m,dkt2ms,dms2kt,dans
      integer, parameter :: func_kind = 16 ! set real kind for function input

 100  format (12x,a,i2)

      if(do_check) then
c     ----------------
c     REAL
c     ----------------      
      write(*,100)'set precision is ',set_precision
      write(*,100)'selected real kind is ',set_kind

      write(*,*)
      write(*,*)'unformatted'
      pdp=precision(ft2m)
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
      call report(dummy,pdp)

      write(*,*)
      write(*,*)'formatted'
      write(fmt3,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
      write(fmt2,'(a,i0.2,a,i0.2,a)')'(a,es',pdp+3+4,'.',pdp,')'

      write(*,fmt3)'   ft2m = ',ft2m
      write(*,fmt2)'   mi2m = ',mi2m
      write(*,fmt3)'   m2ft = ',m2ft
      write(*,fmt2)'   m2mi = ',m2mi    
      write(*,fmt3)'dB_m2yd = ',dB_m2yd
      write(*,fmt3)'dB_yd2m = ',dB_yd2m
      write(*,fmt3)'  kt2ms = ',kt2ms
      write(*,fmt3)'  ms2kt = ',ms2kt
      endif
      
c     ----------------
c     SINGLE PRECISION
c     ----------------
      write(*,*)
      write(*,*)'single precision'
      pdp=precision(sft2m)
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
c     equivalence definitions
      sft2m=real(3048,4)/real(10000,4)
      snmi2m=real(1852,4)
c     functional definitions
      sm2ft=real(1,4)/sft2m
      sm2yd=sm2ft/real(3,4)
      syd2m=real(1,4)/sm2yd
      sdB_m2yd=real(20,4)*log10(sm2yd)
      sdB_yd2m=real(20,4)*log10(syd2m)
      
      sm2nmi=real(1,4)/snmi2m
      sms2kt=sm2nmi*real(3600,4)
      skt2ms=real(1,4)/sms2kt
      
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
      call report(dummy,pdp)
      
      if(do_check) then
c     check differnece
      write(*,*)
      write(*,*) 'single error (write)'
      write(*,fmt)'   ft2m  - ft2m    = ',real(   sft2m,16) - ft2m
      write(*,fmt)'   m2ft  - m2ft    = ',real(   sm2ft,16) - m2ft
      write(*,fmt)'dB_yd2m  - dB_m2yd = ',real(sdB_yd2m,16) - dB_m2yd
      write(*,fmt)'   nmi2m - nmi2m   = ',real(  snmi2m,16) - mi2m
      write(*,fmt)'   m2nmi - m2mi    = ',real(  sm2nmi,16) - m2mi
      write(*,fmt)'   kt2ms - kt2ms   = ',real(  skt2ms,16) - kt2ms   
      write(*,fmt)'   ms2kt - ms2kt   = ',real(  sms2kt,16) - ms2kt
      
      write(*,*)
      write(*,*) 'single error (variable)'
      sans = sft2m - real(ft2m,4)
      write(*,fmt)'   ft2m  - ft2m    = ',   sans
      sans = sm2ft - real(m2ft,4)
      write(*,fmt)'   m2ft  - m2ft    = ',   sans
      sans = sdB_yd2m - real(dB_m2yd,4)
      write(*,fmt)'dB_yd2m  - dB_m2yd = ',sans
      sans = snmi2m - real(mi2m,4)
      write(*,fmt)'   nmi2m - nmi2m   = ',  sans
      sans = sm2nmi - real(m2mi,4)
      write(*,fmt)'   m2nmi - m2mi    = ',   sans
      sans = skt2ms - real(kt2ms,4)
      write(*,fmt)'   kt2ms - kt2ms   = ',  sans   
      sans = sms2kt - real(ms2kt,4)
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
      write(*,100)'single precision accuracy acheived = ',spa
      endif
      
c     ----------------
c     DOUBLE PRECISION
c     ----------------      
      write(*,*)
      write(*,*)'double precision'
      pdp=precision(dft2m)      ! last decimal not consistent
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
c     equivalence definitions
      dft2m=real(3048,8)/real(10000,8)
      dnmi2m=real(1852,8)
c     functional definitions
      dm2ft=real(1,8)/dft2m
      dm2yd=dm2ft/real(3,8)
      dyd2m=real(1,8)/dm2yd
      ddB_m2yd=real(20,8)*log10(dm2yd)
      ddB_yd2m=real(20,8)*log10(dyd2m)
      
      dm2nmi=real(1,8)/dnmi2m
      dms2kt=dm2nmi*real(3600,8)
      dkt2ms=real(1,8)/dms2kt
      
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
      call report(dummy,pdp)
      
      if (do_check) then
      write(*,*)
      write(*,*) 'double error'
      dans = dft2m - real(ft2m,8)
      write(*,fmt)'   ft2m  - ft2m    = ',   dans
      dans = dm2ft - real(m2ft,8)
      write(*,fmt)'   m2ft  - m2ft    = ',   dans
      dans = ddB_yd2m - real(dB_m2yd,8)
      write(*,fmt)'dB_yd2m  - dB_m2yd = ',dans
      dans = dnmi2m - real(mi2m,8)
      write(*,fmt)'   nmi2m - nmi2m   = ',  dans
      dans = dm2nmi - real(m2mi,8)
      write(*,fmt)'   m2nmi - m2mi    = ',   dans
      dans = dkt2ms - real(kt2ms,8)
      write(*,fmt)'   kt2ms - kt2ms   = ',  dans   
      dans = dms2kt - real(ms2kt,8)
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
      write(*,100)'double precision accuracy acheived = ',dpa
      endif

c     --------------
c     QUAD PRECISION
c     --------------      
      write(*,*)
      if(srk.ge.16) then
         write(*,*)'quad precision'
      else if(srk.eq.10) then
         write(*,*)'extended precision'
      else
         write(*,*)'specified precision'
      endif

c     formatting
      pdp=precision(qft2m)
      write(fmt,'(a,i02,a)')'(a,i',ceiling(log10(real(pdp))),')'
      write(*,fmt)'real bytes = ',srk
      
c     equivalence definitions
      qft2m=real(3048,16)/real(10000,16)             ! works for real*16, not real*10
c     qft2m=qft2m/1q4           ! works

      qnmi2m=real(1852,16)

c     functional definitions
      qm2nmi=real(1,16)/qnmi2m
      qms2kt=qm2nmi*real(3600,16)
      qkt2ms=real(1,16)/qms2kt
      
c     printed output
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp-3,')'
c     write(fmt,'(a,i0.2,a,i0.2,a)')'(a,e',pdp+7,'.',pdp,')'
      write(*,fmt)'  nmi2m = ',qnmi2m

      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'
c     write(fmt,'(a,i0.2,a,i0.2,a)')'(a,e',pdp+7,'.',pdp,')'
      write(*,fmt)'  m2nmi = ',qm2nmi
      write(*,fmt)'  kt2ms = ',qkt2ms
      write(*,fmt)'  ms2kt = ',qms2kt
      write(*,*)
      
      write(fmt,'(a,i0.2,a,i0.2,a)')'(a,f',pdp+3,'.',pdp,')'

c     functional definitions
      qm2ft=real(1,16)/qft2m
      qm2yd=qm2ft/real(3,16)
      qyd2m=real(1,16)/qm2yd
      qdB_m2yd=real(20,16)*log10(qm2yd)
      qdB_yd2m=real(20,16)*log10(qyd2m)
      
c     printed output
      write(*,fmt)'   ft2m = ',qft2m
      write(*,fmt)'   m2ft = ',qm2ft
      write(*,fmt)'   m2yd = ',qm2yd
      write(*,fmt)'   yd2m = ',qyd2m
      write(*,fmt)'dB_m2yd = ',qdB_m2yd
      write(*,fmt)'dB_yd2m = ',qdB_yd2m

      dummy=comp_real(real(abs(qdB_m2yd),16),real(abs(qdB_yd2m),16))
      call report(dummy,pdp)

      if (do_check) then
      qpa=0
      dummy=comp_real(real(m2ft,16),real(qm2ft,16))
      if(dummy.gt.qpa)qpa=dummy
      dummy=comp_real(real(m2mi,16),real(qm2nmi,16))
      if(dummy.lt.qpa)qpa=dummy
      dummy=comp_real(real(abs(dB_m2yd),16),real(abs(qdB_m2yd),16))
      if(dummy.lt.qpa)qpa=dummy
      dummy=comp_real(real(abs(dB_yd2m),16),real(abs(qdB_yd2m),16))
      if(dummy.lt.qpa)qpa=dummy
      dummy=comp_real(real(ms2kt,16),real(qms2kt,16))
      if(dummy.lt.qpa)qpa=dummy
      dummy=comp_real(real(kt2ms,16),real(qkt2ms,16))
      if(dummy.lt.qpa)qpa=dummy
      write(*,100)'quad precision accuracy acheived = ',qpa

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
      write(*,100)'accuracy acheived = ',strpa

      write(*,*)
      write(*,100)'precision: ',set_precision
      write(*,100)'accuracy: ',strpa
      if(strpa.ge.set_precision) then
         write(*,100)'worked: ',strpa,' >= ',set_precision
      else
         write(*,100)'failed: ',strpa,' < ',set_precision
      endif
      call report(strpa,set_precision)
      endif

      end
      
      integer function comp_real_str(real_val,str_ref)
      implicit none
      integer(kind=16) i,i_dum,i_ref,i_test,ii,leading_zero
      real(kind=16),intent(in) :: real_val
      character (len=40),intent(in) :: str_ref      
      logical  val_ok
      integer,parameter :: db = 0
c     compare digits
      if(db>0) write(*,*)'comparing digits...'
      ii=0
      leading_zero=0
      val_ok=.true.
      if(db>0) write(*,'(a,f40.38)')'     test value is ',real_val
      if(db>0) write(*,'(a,a,a)')'reference value is ',str_ref
     &     ,' (string)'
      i = int(index(str_ref,'.'),16)
      if(db>1) write(*,*)'decimal point found at ',i
      
      do while (val_ok.and.(ii.lt.len(str_ref)))
         i_test=floor(real_val*10**real(ii,16),16)
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
     $           ,' decimal places of accuracy achieved'
            return
         endif
         ii=ii+1
      enddo
      end

      integer function comp_real(real_val,real_ref)
      implicit none
      real(kind=16),intent(in) :: real_val,real_ref
      integer(kind=16) i_ref,i_test,ii,a,pdp
      real(kind=16) b,sci_val,sci_ref
      logical  val_ok
      character(len=40) fmt
      integer,parameter :: db=0
      if(db>0) write(*,*)'comparing digits...'
      pdp=precision(real_val)
c     convert to scientific notation
      a=floor(log10(real_val),16)
      b=10**(real(-1,16)*real(a,16))
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
         i_test=floor(sci_val*10**real(ii,16),16)
         i_ref=floor(sci_ref*10**real(ii,16),16)
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

      subroutine report(acc,prec)
      implicit none
      integer,intent(in) :: acc,prec
      write(*,100) ' precision  = ',acc
      write(*,200)acc
      if(acc.ge.prec) then
         write(*,100)'worked: ',acc,' >= ',prec
      else
         write(*,100)'failed: ',acc,' < ',prec
      endif
 100  format (12x,a,i2)
 200  format (i2
     &     ,' decimal places of accuracy (self-consistency) achieved')
      end
