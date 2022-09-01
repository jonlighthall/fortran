# (fortran) compiler
your_f77 = gfortran
# (fortran) compile flags
options = -fimplicit-none
warnings = -pedantic -Wall -Wsurprising -W
output =  -o $@

# (fortran) compile flags
compile = -c $^
fcflags = $(options) $(warnings) $(output) $(compile)
F.COMPILE.f = $(your_f77) $(fcflags) -fd-lines-as-comments
F.COMPILE.f90 = $(your_f77) $(fcflags)

# (fortran) link flags
flflags =  $(output) $^
F.LINK = $(your_f77) $(flflags)

all: $(addsuffix .exe, basel test_pi borwein leibniz wallis pi_monte_carlo)

basel.exe: basel.f 
	@echo compiling executable $@...	
	$(F.LINK) -fdefault-real-8 -fdefault-integer-8

%.o: %.f | makefile
	@echo compiling object file $@...	
	$(F.COMPILE.f)

%.o: %.f90 | makefile
	@echo compiling f90 object file $@...	
	$(F.COMPILE.f90)

%.exe: %.o
	@echo compiling executable $@...	
	$(F.LINK)

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
