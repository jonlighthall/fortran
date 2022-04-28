      program extrema
      implicit none
      integer(kind=1) i,a,b,c,d,e
      integer(kind=2) j
      integer(kind=4) k
      integer(kind=8) l
      integer(kind=16) m
      character(len=56) str

c     a quad read is declared to avoid real-literal-constant warning
      real(kind=16) quad
      write(*,'(t3,a,t16,a,t33,a,t59,a)')'integer','real','double'
     $     ,'quad'
      print *, huge(0), huge(0e0), huge(0d0), huge(quad), 'max'
      print *, 1, tiny(0e0), tiny(0d0), tiny(quad), 'min'
      write(*,*) 1, epsilon(0e0), epsilon(0d0), epsilon(quad), 'eps'

      write(*,*) 'integers'
      write(*,*) huge(int(0,1))
      write(*,*) huge(int(0,2))
      write(*,*) huge(int(0,4))
      write(*,*) huge(int(0,8))
      write(*,*) huge(int(0,16))

      i = huge(int(0,1))
      j = huge(int(0,2))
      k = huge(int(0,4))
      l = huge(int(0,8))
      m = huge(int(0,16))

      write(*,*) 'log, literal constants'
      write(*,*) log10(real(i))
      write(*,*) log10(real(j))
      write(*,*) log10(real(k))
      write(*,*) log10(real(l))
      write(*,*) log10(real(m))

      write(*,*) 'floor(log), literal constants'
      write(*,100) floor(log10(real(i)))
      write(*,100) floor(log10(real(j)))
      write(*,100) floor(log10(real(k)))
      write(*,100) floor(log10(real(l)))
      write(*,100) floor(log10(real(m)))

      write(*,*) 'string length'
      write(str,'(i56)') i
      a=len(trim(adjustl(str)),1)
      write(*,100) a
      write(str,'(i56)') j
      b=len(trim(adjustl(str)),1)
      write(*,100) b
      write(str,'(i56)') k
      c=len(trim(adjustl(str)),1)
      write(*,100) c
      write(str,'(i56)') l
      d=len(trim(adjustl(str)),1)
      write(*,100) d
      write(str,'(i56)') m
      e=len(trim(adjustl(str)),1)
      write(*,100) e
      
      i = floor(log10(real(i)),1)
      j = floor(log10(real(j)),2)
      k = floor(log10(real(k)))
      l = floor(log10(real(l)))
      m = floor(log10(real(m)))

      write(*,*) 'floor(log), variable'
      write(*,100) i
      write(*,100) j
      write(*,100) k
      write(*,100) l
      write(*,100) m

      write(*,*) 'equvialence test'
      write(*,*) i.eq.(a-1)
      write(*,*) j.eq.(b-1)
      write(*,*) k.eq.(c-1)
      write(*,*) l.eq.(d-1)
      write(*,*) m.eq.(e-1)      

      i = floor(log10(real(huge(int(0,1)))),1)
      j = floor(log10(real(huge(int(0,2)))),2)
      k = floor(log10(real(huge(int(0,4)),8)))
      l = floor(log10(real(huge(int(0,8)),16)))
c     m = floor(log10(real(huge(int(0,16)),16)))
      m=e-1

      write(*,*) 'floor(log(huge)), variable'
      write(*,100) i
      write(*,100) j
      write(*,100) k
      write(*,100) l
      write(*,100) m

 100  FORMAT(i2)
      
      end program extrema
