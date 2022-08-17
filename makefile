# fortran compiler
FC = gfortran
# general flags
compile_flags = -c $<
output_flags = -o $@
options = -fimplicit-none -fd-lines-as-comments
warnings = -Wall -Wsurprising -W -pedantic -Warray-temporaries	\
-Wcharacter-truncation -Wconversion-extra -Wimplicit-interface	\
-Wimplicit-procedure -Winteger-division -Wintrinsics-std	\
-Wreal-q-constant -Wuse-without-only -Wrealloc-lhs-all
debug = -g							\
-ffpe-trap=invalid,zero,overflow,underflow,inexact,denormal	\
-fcheck=all -fbacktrace
# fortran compile flags
FCFLAGS =  $(options) $(warnings)
FC.COMPILE = $(FCFLAGS) $(output_flags) $(compile_flags)
FC.COMPILE.o = $(FC) $(FC.COMPILE) 
#
# fortran link flags
flink = $(output_flags) $^
FC.LINK = $(FC) $(flink)
#
# dependencies
SRC = $(wildcard *.f)
OBJS = $(SRC:.f=.o)

all: $(addsuffix .exe, hello fundem ar global sys subs globsubs		\
	test_abs sign io timedate pause test_system_clock make_svp	\
	collatz huge collatz_loop interrupt extrema fmt timer units	\
	ask fun dice collatz_glide test_getunit gethost )
	$(MAKE)	-C pi

ar.exe: ar.o
	$(FC.LINK)

collatz.exe: collatz.o format.o | set_format.f
	@echo "compiling executable $@..."
	$(FC.LINK) -fno-range-check -Wno-unused-parameter

collatz_loop.exe: collatz_loop.o format.o | set_format.f
	@echo "compiling executable $@..."
	$(FC.LINK) -fno-range-check

fmt.exe: fmt.o format.o | set_format.f
	@echo "compiling executable $@..."
	$(FC.LINK)

global.exe: global.o | araydim.inc
	@echo "compiling executable $@..."
	$(FC.LINK)

globsubs.exe: globsubs.o f.o | araydim.inc
	@echo "compiling executable $@..."
	$(FC.LINK) 

huge.exe: huge.o format.o | set_format.f
	@echo "compiling executable $@..."
	$(FC.LINK)

test_getunit.exe: test_getunit.o getunit.o
	@echo "compiling executable $@..."
	$(FC.LINK)

pause.exe: pause.o
	@echo "compiling executable $@..."
	$(FC.LINK) -w -std=legacy 

subs.exe: subs.o f.o f2.o
	@echo "compiling executable $@..."
	$(FC.LINK)

test_system_clock.exe: test_system_clock.o format.o | set_format.f
	@echo "compiling executable $@..."
	$(FC.LINK) 

units.exe: units.o | metrics_revised2.inc
	@echo "compiling executable $@..."
	$(FC.LINK) -Wno-conversion

%.o: %.f makefile
	@echo "compiling object $@..."
	$(FC.COMPILE.o)

%.exe: %.o
	@echo "executable $@..."
	$(FC.LINK)	

run: all # test all functions that run automatically
	./ar.exe 
	./extrema.exe
	./fmt.exe
	./fun.exe
	./global.exe 
	./globsubs.exe
	./hello.exe 
	./huge.exe
	./io.exe
	./make_svp.exe
	./test_getunit.exe
	./sign.exe
	./subs.exe
	./sys.exe 
	./test_abs.exe
	./test_system_clock.exe
	./timedate.exe
	./units.exe
	./gethost.exe

run_man: all # test all functions that require manual input
	./ask.exe
	./collatz.exe
	./collatz_glide.exe	
	./fundem.exe 
	./pause.exe

run_int: all # test all functions that require user interrupt
	./collatz_loop.exe; \
	./interrupt.exe; \
	./timer.exe

run_fmt: all # test all functions that require set_fmt.f
	./collatz.exe
	./collatz_loop.exe; \
	./fmt.exe; \
	./huge.exe; \
	./test_system_clock.exe

CMD = @rm -vfrd
clean:
	@echo removing files...	
# remove compiled binaries
	$(CMD) *.o *.obj
	$(CMD) *.mod
	$(CMD) *.exe
	$(CMD) *.out
	$(CMD) fort.*
	$(MAKE) clean -C pi
distclean: clean
	$(CMD) fname*.in
	$(CMD) svp.out
	$(CMD) svp.in
	$(CMD) state
	$(CMD) test
	$(CMD) test?
# remove Git versions
	$(CMD) *.~*~
# remove Emacs backup files
	$(CMD) *~ \#*\#
