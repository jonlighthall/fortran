# (fortran) compiler
your_f77 = gfortran
# (fortran) compile flags
fcflags = -fimplicit-none -pedantic -Wall -Wsurprising -W	\
-fd-lines-as-comments
# (fortran) link flags
flflags = -c $(fcflags)

all: hello.exe fundem.exe ar.exe global.exe sys.exe subs.exe		\
	globsubs.exe test_abs.exe sign.exe io.exe timedate.exe		\
	pause.exe test_system_clock.exe make_svp.exe collatz.exe	\
	huge.exe collatz_loop.exe interrupt.exe extrema.exe		\
	fmt.exe timer.exe units.exe ask.exe fun.exe	\
	dice.exe collatz_glide.exe test_getunit.exe
	$(MAKE)	-C pi

ar.exe: ar.f f.f
	$(your_f77) $(fcflags) $< -o $@	

collatz.exe: collatz.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) $(fcflags) -fno-range-check -Wno-unused-parameter $< -o $@

collatz_loop.exe: collatz_loop.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) $(fcflags) -fno-range-check $< format.f -o $@

fmt.exe: fmt.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) $(fcflags) $< format.f -o $@

global.exe: global.f araydim.inc
	@echo compiling $<...	
	$(your_f77) $(fcflags) $< -o $@

globsubs.exe: globsubs.f f.f araydim.inc
	@echo compiling $<...	
	$(your_f77) $(fcflags) $< f.f -o $@

huge.exe: huge.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) $(fcflags) $< format.f -o $@

test_getunit.exe: test_getunit.f getunit.f
	@echo compiling $<...
	$(your_f77) $(fcflags) $^ -o $@

pause.exe: pause.f
	@echo compiling $<...	
	$(your_f77) $(fcflags) -w -std=legacy  $^ -o $@

subs.exe: subs.f f.f f2.f
	@echo compiling $<...	
	$(your_f77) $(fcflags) $^ -o $@

set_format.exe: set_format.f
	@echo compiling $<...	
	$(your_f77) $(fcflags) -Wno-unused-parameter $^ -o $@

test_system_clock.exe: test_system_clock.f format.f set_format.f
	@echo compiling $<...
	$(your_f77) $(fcflags) $< format.f -o $@	

units.exe: units.f metrics_revised2.inc
	@echo compiling $<...	
	$(your_f77) $(fcflags) -Wno-conversion $< -o $@

%.o: %.f makefile
	@echo compiling $<...	
	$(your_f77) $(flflags) $<

%.exe: %.o
	$(your_f77) $(fcflags) $^ -o $@	

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
	./getunit_test.exe
	./sign.exe
	./subs.exe
	./sys.exe 
	./test_abs.exe
	./test_system_clock.exe
	./timedate.exe
	./units.exe

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
	./collatz_loop.exe
	./fmt.exe
	./huge.exe
	./test_system_clock.exe

clean:
	@echo removing files...
	@for fname in *.exe *.o *.f.~*~ fname*.in svp.out svp.in \
	state test? a.out ; \
	do \
		find ./ -type f -name $${fname} -exec rm {} \; ; \
	done
	$(MAKE) clean -C pi
