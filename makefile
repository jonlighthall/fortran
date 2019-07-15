# (fortran) compiler
your_f77 = gfortran
# (fortran) compile flags
fcflags =
# (fortran) link flags
flflags = -c $(fcflags)

all: hello.exe fundem.exe ar.exe global.exe sys.exe subs.exe globsubs.exe \
	test_abs.exe sign.exe io.exe timedate.exe pause.exe \
	test_system_clock.exe make_svp.exe collatz.exe huge.exe \
	collatz_loop.exe interrupt.exe extrema.exe newunit.exe

global.exe: global.f araydim.inc
	$(your_f77) $(fcflags) global.f -o $@

subs.exe: subs.o f.o f2.o
	$(your_f77) $(fcflags) $^ -o $@	

globsubs.exe: globsubs.o f.o araydim.inc
	$(your_f77) $(fcflags) globsubs.o f.o  -o $@	

pause.exe: pause.f
	@echo compiling $<...	
	 $(your_f77) -std=legacy  $^ -o $@	

collatz.exe: collatz.f
	@echo compiling $<...	
	 $(your_f77) -fno-range-check $^ -o $@

collatz_loop.exe: collatz_loop.f
	@echo compiling $<...	
	 $(your_f77) -fno-range-check $^ -o $@

newunit_test.exe: newunit_test.o newunit.o
	@echo compiling $<...	
	 $(your_f77) $^ -o $@

clean:
	@echo removing files...
	rm -f *.exe
	rm -f *.o

%.o: %.f	
	@echo compiling $<...	
	 $(your_f77) $(flflags) $<

%.exe: %.o
	$(your_f77) $(fcflags) $^ -o $@	