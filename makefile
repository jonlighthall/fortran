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

subs.exe: subs.f f.f f2.f
	$(your_f77) $^ -o $@

globsubs.exe: globsubs.f f.f araydim.inc
	$(your_f77) globsubs.f f.f -o $@

pause.exe: pause.f
	@echo compiling $<...	
	$(your_f77) -std=legacy  $^ -o $@

test_system_clock.exe: test_system_clock.f format.f set_format.f
	$(your_f77) test_system_clock.f format.f -o $@	
	rm -f test_system_clock.o format.o

collatz.exe: collatz.f format.f set_format.f
	$(your_f77) -fno-range-check collatz.f -o $@
	rm -f collatz.o format.o

collatz_loop.exe: collatz_loop.f format.f set_format.f
	$(your_f77) -fno-range-check collatz_loop.f format.f -o $@
	rm -f collatz_loop.o format.o

huge.exe: huge.f format.f set_format.f
	$(your_f77) huge.f format.f -o $@
	rm -f huge.o format.o

newunit_test.exe: newunit_test.f newunit.f
	$(your_f77) $^ -o $@

fmt.exe: fmt.f format.f set_format.f
	$(your_f77) fmt.f format.f -o $@
	rm -f fmt.o format.o

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
	rm -fv a.out

%.o: %.f	
	@echo compiling $<...	
	$(your_f77) $(flflags) $<

%.exe: %.o
	$(your_f77) $(fcflags) $^ -o $@	

run: all # test all functions that run automatically
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
	./units.exe

run_man: all # test all functions that require manual input
	./fundem.exe 
	./pause.exe
	./collatz.exe	

run_int: all # test all functions that require user interrupt
	./collatz_loop.exe; \
	./interrupt.exe; \
	./timer.exe