# fortran compiler
your_f77 = gfortran
# flags
output = -o $@
compile = -c $<
options = -fimplicit-none -fd-lines-as-comments
warnings = -pedantic -Wall -Wsurprising -W

# fortran compile flags
fcompile = $(compile) $(warnings) $(options) $(output)
# fortran link flags
flink = $(output) $^

all: hello.exe fundem.exe ar.exe global.exe sys.exe subs.exe		\
	globsubs.exe test_abs.exe sign.exe io.exe timedate.exe		\
	pause.exe test_system_clock.exe make_svp.exe collatz.exe	\
	huge.exe collatz_loop.exe interrupt.exe extrema.exe fmt.exe	\
	timer.exe units.exe ask.exe fun.exe dice.exe			\
	collatz_glide.exe test_getunit.exe gethost.exe
	$(MAKE)	-C pi

ar.exe: ar.o
	$(your_f77) $(flink)

collatz.exe: collatz.o format.o | set_format.f
	@echo compiling $<...	
	$(your_f77) $(flink) -fno-range-check -Wno-unused-parameter

collatz_loop.exe: collatz_loop.o format.o | set_format.f
	@echo compiling $<...	
	$(your_f77) $(flink) -fno-range-check

fmt.exe: fmt.o format.o | set_format.f
	@echo compiling $<...	
	$(your_f77) $(flink)

global.exe: global.o | araydim.inc
	@echo compiling $<...	
	$(your_f77) $(flink)

globsubs.exe: globsubs.o f.o | araydim.inc
	@echo compiling $<...	
	$(your_f77) $(flink) 

huge.exe: huge.o format.o | set_format.f
	@echo compiling $<...	
	$(your_f77) $(flink)

test_getunit.exe: test_getunit.o getunit.o
	@echo compiling $@...
	$(your_f77) $(flink)

pause.exe: pause.o
	@echo compiling $<...	
	$(your_f77) $(flink) -w -std=legacy 

subs.exe: subs.o f.o f2.o
	@echo compiling $<...	
	$(your_f77) $(flink)

test_system_clock.exe: test_system_clock.o format.o | set_format.f
	@echo compiling $<...
	$(your_f77) $(flink) 

units.exe: units.o | metrics_revised2.inc
	@echo compiling $<...	
	$(your_f77) $(flink) -Wno-conversion

%.o: %.f makefile
	@echo compiling $<...	
	$(your_f77) $(fcompile)

%.exe: %.o
	@echo linking $<...	
	$(your_f77) $(flink)	

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
