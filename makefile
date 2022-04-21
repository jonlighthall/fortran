# (fortran) compiler
your_f77 = gfortran
# (fortran) compile flags
fcflags =
# (fortran) link flags
flflags = -c $(fcflags)

all: hello.exe fundem.exe ar.exe global.exe sys.exe subs.exe globsubs.exe \
	test_abs.exe sign.exe io.exe timedate.exe pause.exe \
	test_system_clock.exe make_svp.exe collatz.exe huge.exe \
	collatz_loop.exe interrupt.exe extrema.exe newunit_test.exe \
	fmt.exe timer.exe units.exe ask.exe fun.exe dice.exe collatz_glide.exe
	$(MAKE)	-C pi

units.exe: units.f metrics_revised2.inc
	@echo compiling $<...	
	$(your_f77) $(fcflags) $< -o $@

global.exe: global.f araydim.inc
	@echo compiling $<...	
	$(your_f77) $(fcflags) global.f -o $@

subs.exe: subs.f f.f f2.f
	@echo compiling $<...	
	$(your_f77) $^ -o $@

globsubs.exe: globsubs.f f.f araydim.inc
	@echo compiling $<...	
	$(your_f77) globsubs.f f.f -o $@

pause.exe: pause.f
	@echo compiling $<...	
	$(your_f77) -std=legacy  $^ -o $@

test_system_clock.exe: test_system_clock.f format.f set_format.f
	@echo compiling $<...
	$(your_f77) test_system_clock.f format.f -o $@	

collatz.exe: collatz.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) -fno-range-check collatz.f -o $@

collatz_loop.exe: collatz_loop.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) -fno-range-check collatz_loop.f format.f -o $@

huge.exe: huge.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) huge.f format.f -o $@

newunit_test.exe: newunit_test.f newunit.f
	@echo compiling $<...
	$(your_f77) $^ -o $@

fmt.exe: fmt.f format.f set_format.f
	@echo compiling $<...	
	$(your_f77) fmt.f format.f -o $@

clean:
	@echo removing files...
	@for fname in *.exe *.o *.f.~*~ fname*.in svp.out svp.in \
	state test? a.out ; \
	do \
		find ./ -type f -name $${fname} -exec rm -v {} \; ; \
	done
	$(MAKE) clean -C pi

%.o: %.f
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
	./newunit_test.exe
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
