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
	@for fname in *.exe *.o *.f.~*~ a.out ; \
	do \
		find ./ -type f -name $${fname} -exec rm -v {} \; ; \
	done

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
