# fortran compiler
FC = gfortran
#
# general flags
compile = -c $<
output = -o $@
includes =
options = -fimplicit-none
warnings = -Wall -Wsurprising -W -pedantic -Warray-temporaries	\
-Wcharacter-truncation -Wconversion-extra -Wimplicit-interface	\
-Wimplicit-procedure -Winteger-division -Wintrinsics-std	\
-Wreal-q-constant -Wuse-without-only -Wrealloc-lhs-all
debug = -g -fbacktrace -fcheck=all			\
-ffpe-trap=invalid,zero,overflow,underflow,denormal
#
# fortran compile flags
FCFLAGS = $(compile) $(includes) $(options) $(warnings)
F77.FLAGS = -fd-lines-as-comments
F90.FLAGS = -std=f2008 $(debug)
FC.COMPILE = $(FC) $(FCFLAGS)
FC.COMPILE.o = $(FC.COMPILE)  $(output) $(F77.FLAGS)
FC.COMPILE.o.f90 = $(FC.COMPILE) $(output) $(F90.FLAGS)
FC.COMPILE.mod = $(FC.COMPILE) -o $(OBJDIR)/$*.o $(F90.FLAGS)
#
# fortran link flags
FLFLAGS = $(output) $^
FC.LINK = $(FC) $(FLFLAGS)

all: $(addsuffix .exe, basel test_pi borwein leibniz wallis pi_monte_carlo)
#
# specific recipes
basel.exe: basel.f 
	@echo compiling executable $@...	
	$(FC.LINK) -fdefault-real-8 -fdefault-integer-8

pi_monte_carlo.o: pi_monte_carlo.f90
	@echo compiling f90 object file $@...	
	$(FC.COMPILE.o.f90) -std=legacy
#
# generic recipies
%.exe: %.o
	@echo compiling executable $@...	
	$(FC.LINK)

%.o: %.f | makefile
	@echo compiling object file $@...	
	$(FC.COMPILE.o)

%.o: %.f90 | makefile
	@echo compiling f90 object file $@...	
	$(FC.COMPILE.o.f90)

run: all # test all functions that run automatically
	./basel.exe
	./borwein.exe
	./leibniz.exe
	./test_pi.exe
	./wallis.exe

clean:
	@echo removing files...
	@for fname in *.exe *.o *.f.~*~ a.out ; \
	do \
		find ./ -type f -name $${fname} -exec rm {} \; ; \
	done
