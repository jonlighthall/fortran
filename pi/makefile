# (fortran) compiler
your_f77 = x86_64-w64-mingw32-gfortran
# (fortran) compile flags
fcflags = -static
# (fortran) link flags
flflags = -c $(fcflags)

all: basel.exe test_pi.exe borwein.exe leibniz.exe wallis.exe

basel.exe: basel.f 
	@echo compiling $<...	
	$(your_f77) $(fcflags) -fdefault-real-8 -fdefault-integer-8 $^ -o $@

%.o: %.f makefile
	@echo compiling $<...	
	$(your_f77) $(flflags) $<

%.exe: %.o
	$(your_f77) $(fcflags) $^ -o $@	

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
