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
flink = $(output)

all: hello.exe fundem.exe ar.exe global.exe sys.exe subs.exe		\
	globsubs.exe test_abs.exe sign.exe io.exe timedate.exe		\
	pause.exe test_system_clock.exe make_svp.exe collatz.exe	\
	huge.exe collatz_loop.exe interrupt.exe extrema.exe fmt.exe	\
	timer.exe units.exe ask.exe fun.exe dice.exe			\
	collatz_glide.exe test_getunit.exe gethost.exe
	$(MAKE)	-C pi

ar.exe: ar.f f.f
	$(your_f77) $(flink) $< 

collatz.exe: collatz.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) $(flink) -fno-range-check -Wno-unused-parameter $<

collatz_loop.exe: collatz_loop.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) $(flink) -fno-range-check $< format.f

fmt.exe: fmt.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) $(flink) $< format.f

global.exe: global.f araydim.inc
	@echo compiling $<...	
	$(your_f77) $(flink) $<

globsubs.exe: globsubs.f f.f araydim.inc
	@echo compiling $<...	
	$(your_f77) $(flink) $< f.f

huge.exe: huge.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) $(flink) $< format.f

test_getunit.exe: test_getunit.o getunit.o
	@echo compiling $@...
	$(your_f77) $(flink) $^

pause.exe: pause.f
	@echo compiling $<...	
	$(your_f77) $(flink) -w -std=legacy  $^

subs.exe: subs.f f.f f2.f
	@echo compiling $<...	
	$(your_f77) $(flink) $^

set_format.exe: set_format.f
	@echo compiling $<...	
	$(your_f77) $(flink) -Wno-unused-parameter $^

test_system_clock.exe: test_system_clock.f format.f set_format.f
	@echo compiling $<...
	$(your_f77) $(flink) $< format.f	

units.exe: units.f metrics_revised2.inc
	@echo compiling $<...	
	$(your_f77) $(flink) -Wno-conversion $<

%.o: %.f makefile
	@echo compiling $<...	
	$(your_f77) $(fcompile)

%.exe: %.o
	@echo linking $<...	
	$(your_f77) $(flink) $^	

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
