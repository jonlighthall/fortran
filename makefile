# (fortran) compiler
your_f77 = gfortran
# (fortran) compile flags
fcflags = 
# (fortran )link flags
flflags = -c $(fcflags)

all: hello.exe fundem.exe ar.exe global.exe sys.exe subs.exe globsubs.exe test_abs.exe

hello.exe: hello.f
	@echo compiling hello...
	$(your_f77) $(fcflags) $^ -o $@

fundem.exe: fundem.f
	@echo compiling fundem...
	$(your_f77) $(fcflags) $^ -o $@

ar.exe: ar.f
	@echo compiling ar...
	$(your_f77) $(fcflags) $^ -o $@

global.exe: global.f araydim.inc
	$(your_f77) $(fcflags) global.f -o $@

sys.exe: sys.f
	$(your_f77) $(fcflags) $^ -o $@

subs.exe: subs.o f.o f2.o
	$(your_f77) $(fcflags) $^ -o $@	

globsubs.exe: globsubs.o f.o araydim.inc
	$(your_f77) $(fcflags) globsubs.o f.o  -o $@	

test_abs.exe: test_abs.f
	$(your_f77) $(fcflags) $^ -o $@	

clean:
	@echo removing files...
	rm *.exe
	rm *.o

%.o: %.f	
	 $(your_f77) $(flflags) $<

