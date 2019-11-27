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
	fmt.exe timer.exe units.exe

global.exe: global.f araydim.inc
	$(your_f77) $(fcflags) global.f -o $@

subs.exe: subs.o f.o f2.o
	$(your_f77) $(fcflags) $^ -o $@	

globsubs.exe: globsubs.o f.o araydim.inc
	$(your_f77) $(fcflags) globsubs.o f.o  -o $@

pause.exe: pause.f
	@echo compiling $<...	
	 $(your_f77) -std=legacy  $^ -o $@	

test_system_clock.exe: format.o test_system_clock.o set_format.f
	@echo compiling $<...		
	 $(your_f77) format.o test_system_clock.o -o $@	

collatz.exe: collatz.o set_format.f
	@echo compiling $<...	
	 $(your_f77) -fno-range-check collatz.o -o $@

collatz_loop.exe: collatz_loop.o format.o set_format.f
	@echo compiling $<...	
	 $(your_f77) -fno-range-check collatz_loop.o format.o -o $@

huge.exe: huge.o format.o set_format.f
	@echo compiling $<...	
	 $(your_f77) huge.f format.o -o $@

newunit_test.exe: newunit_test.o newunit.o
	@echo compiling $<...	
	 $(your_f77) $^ -o $@

fmt.exe: fmt.o format.o set_format.f
	@echo compiling $<...		
	 $(your_f77) fmt.o format.o  -o $@	

clean:
	@echo removing files...
	rm -fv *.exe
	rm -fv *.o
	rm -fv *.f.~*~
	rm -fv fname*.in
	rm -fv svp.out
	rm -fv svp.in
	rm -fv state
	rm -fv test?

%.o: %.f	
	@echo compiling $<...	
	 $(your_f77) $(flflags) $<

%.exe: %.o
	$(your_f77) $(fcflags) $^ -o $@	

test_auto: all # test all functions that run automatically
	./hello.exe 
	./ar.exe 
	./global.exe 
	./sys.exe 
	./subs.exe
	./globsubs.exe
	./test_abs.exe
	./sign.exe
	./io.exe
	./timedate.exe
	./test_system_clock.exe
	./make_svp.exe
	./huge.exe
	./extrema.exe
	./newunit_test.exe
	./fmt.exe

test_man: all # test all functions that require manual input
	./fundem.exe 
	./pause.exe
	./collatz.exe	

test_int: all # test all functions that require user interrupt
	./collatz_loop.exe
	./interrupt.exe
	./timer.exe
