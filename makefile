# (fortran) compiler
your_f77 = gfortran
# (fortran) compile flags
fcflags =
# (fortran) link flags
flflags = -c $(fcflags)

all: hello.exe fundem.exe ar.exe global.exe sys.exe subs.exe globsubs.exe \
	test_abs.exe 

global.exe: global.f araydim.inc
	$(your_f77) $(fcflags) global.f -o $@

subs.exe: subs.o f.o f2.o
	$(your_f77) $(fcflags) $^ -o $@	

globsubs.exe: globsubs.o f.o araydim.inc
	$(your_f77) $(fcflags) globsubs.o f.o  -o $@	

clean:
	@echo removing files...
	rm -f *.exe
	rm -f *.o

%.o: %.f	
	@echo compiling $<...	
	 $(your_f77) $(flflags) $<

%.exe: %.o
	$(your_f77) $(fcflags) $^ -o $@	