# fortran compiler
FC = gfortran
#
# general flags
compile = -c $<
output = -o $@
includes = -I $(INCDIR) -J $(MODDIR)
options = -fimplicit-none
warnings = -Wall -Wsurprising -W -pedantic -Warray-temporaries	\
-Wcharacter-truncation -Wconversion-extra -Wimplicit-interface	\
-Wimplicit-procedure -Winteger-division -Wintrinsics-std	\
-Wreal-q-constant -Wuse-without-only -Wrealloc-lhs-all
debug = -g							\
-ffpe-trap=invalid,zero,overflow,underflow,inexact,denormal	\
-fcheck=all -fbacktrace
#
# fortran compile flags
FCFLAGS = $(compile) $(includes) $(options) $(warnings)
F77.FLAGS = -fd-lines-as-comments -Wno-tabs
F90.FLAGS = -std=f2008 $(debug)
FC.COMPILE = $(FC) $(FCFLAGS)
FC.COMPILE.o = $(FC.COMPILE)  $(output) $(F77.FLAGS)
FC.COMPILE.o.f90 = $(FC.COMPILE) $(output) $(F90.FLAGS)
FC.COMPILE.mod = $(FC.COMPILE) -o $(OBJDIR)/$*.o $(F90.FLAGS)
#
# fortran link flags
FLFLAGS = $(output) $^
FC.LINK = $(FC) $(FLFLAGS)
#
# define subdirectories
OBJDIR := obj
MODDIR := mod
BINDIR := bin
INCDIR := inc
#
# source files
SRC.F77 = $(wildcard *.f)
SRC.F90 = $(wildcard *.f90)
SRC = $(SRC.F77) $(SRC.F90)
#
# objects
OBJS.F77 = $(SRC.F77:.f=.o)
OBJS.F90 = $(SRC.F90:.f90=.o)
OBJS.all = $(OBJS.F77) $(OBJS.F90)
#
# dependencies (non-executables)
MODS. = version
SUBS. = f2 f format
FUNS. = getunit
DEPS. = $(MODS.) $(SUBS.) $(FUNS.)

DEPS.o = $(addsuffix .o,$(DEPS.))
OBJS.o = $(filter-out $(DEPS.o),$(OBJS.all))
MODS.mod = $(addsuffix .mod,$(MODS))

DEPS := $(addprefix $(OBJDIR)/,$(DEPS.o))
OBJS := $(addprefix $(OBJDIR)/,$(OBJS.o))
MODS := $(addprefix $(MODDIR)/,$(MODS.mod))
#
# executables
EXES = $(addprefix $(BINDIR)/,$(OBJS.o:.o=.exe))

all: $(EXES) | $(OBJS) $(DEPS) $(MODS)
	$(MAKE)	-C pi
	@echo "$@ done"
printvars:
	@echo $@:
	@echo
	@echo "SRC = $(SRC)"
	@echo
	@echo "OBJS.all = $(OBJS.all)"

	@echo	
	@echo "----------------------------------------------------"
	@echo

	@echo "MODS. = $(MODS.)"
	@echo
	@echo "SUBS. = $(SUBS.)"
	@echo
	@echo "FUNS. = $(FUNS.)"
	@echo
	@echo "DEPS. = $(DEPS.)"

	@echo
	@echo "----------------------------------------------------"
	@echo

	@echo "OBJS.o = $(OBJS.o)"
	@echo
	@echo "DEPS.o = $(DEPS.o)"
	@echo
	@echo "MODS.mod = $(MODS.mod)"

	@echo
	@echo "----------------------------------------------------"
	@echo

	@echo "EXES = $(EXES)"
	@echo
	@echo "OBJS = $(OBJS)"
	@echo
	@echo "DEPS = $(DEPS)"
	@echo
	@echo "MODS = $(MODS)"
	@echo

	@echo "$@ done"
#
# specific recipes
$(BINDIR)/ar.exe: $(OBJDIR)/ar.o | $(BINDIR)
	@echo "compiling special executable $@..."
	$(FC.LINK)
#
# generic recipies
$(BINDIR)/%.exe: $(OBJDIR)/%.o $(DEPS) | $(BINDIR)
	@echo "\nlinking generic executable $@..."
	$(FC.LINK)	
$(OBJDIR)/%.o: %.f $(MODS) | $(OBJDIR)
	@echo "\ncompiling generic object $@..."
	$(FC.COMPILE.o)
$(OBJDIR)/%.o: %.f90 $(MODS) | $(OBJDIR)
	@echo "\ncompiling generic f90 object $@..."
	$(FC.COMPILE.o.f90)
$(OBJDIR)/%.o: $(INCDIR)/%.f $(MODS) | $(OBJDIR) $(MODDIR)
	@echo "\ncompiling generic include object $@..."
	$(FC.COMPILE.o)
$(OBJDIR)/%.o: $(INCDIR)/%.f90 $(MODS) | $(OBJDIR) $(MODDIR)
	@echo "\ncompiling generic include f90 object $@..."
	$(FC.COMPILE.o.f90)
$(MODDIR)/%.mod: $(INCDIR)/%.f90 | $(OBJDIR) $(MODDIR)
	@echo "\ncompiling generic f90 module $@..."
	$(FC.COMPILE.mod)
#
# define directory creation
$(OBJDIR):
	@mkdir -v $(OBJDIR)
$(BINDIR):
	@mkdir -v $(BINDIR)
$(MODDIR):
	@mkdir -v $(MODDIR)
# keep intermediate object files
.SECONDARY: $(OBJS) $(MODS)
#
# recipes without outputs
.PHONY: clean out distclean
#
# clean up routines
CMD = @rm -vfrd
clean:
	@echo removing files...
# remove compiled binaries
	$(CMD) $(OBJDIR)/*.o
	$(CMD) $(OBJDIR)
	$(CMD) *.o *.obj
	$(CMD) $(MODDIR)/*.mod
	$(CMD) $(MODDIR)
	$(CMD) *.mod
	$(CMD) $(BINDIR)/*.exe
	$(CMD) $(BINDIR)
	$(CMD) *.exe
	$(CMD) *.out
	$(CMD) fort.*
	$(MAKE) clean -C pi
	@echo "$@ done"
out:
	$(CMD) fname*.in
	$(CMD) svp.out
	$(CMD) svp.in
	$(CMD) state
	$(CMD) test
	$(CMD) test?
	@echo "$@ done"
distclean: clean out
# remove Git versions
	$(CMD) *.~*~
# remove Emacs backup files
	$(CMD) *~ \#*\#
	@echo "$@ done"
#
# test the makefile
test: distclean printvars all
	@echo "$@ done"
#
# run executables
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
	./test_getunit.exe
	./sign.exe
	./subs.exe
	./sys.exe
	./test_abs.exe
	./test_system_clock.exe
	./timedate.exe
	./units.exe
	./gethost.exe

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
	./collatz_loop.exe; \
	./fmt.exe; \
	./huge.exe; \
	./test_system_clock.exe
