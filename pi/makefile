# (fortran) compiler
your_f77 = gfortran
# (fortran) compile flags
fcflags =
# (fortran) link flags
flflags = -c $(fcflags)

all: basel.exe test_pi.exe borwein.exe leibniz.exe wallis.exe

basel.exe: basel.f 
	@echo compiling $<...	
	$(your_f77) -fdefault-real-8 -fdefault-integer-8 $^ -o $@

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
	./basel.exe
	./test_pi.exe
	./borwein.exe
	./leibniz.exe
	./wallis.exe
