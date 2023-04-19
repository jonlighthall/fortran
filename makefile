THISDIR=$(shell \pwd | sed 's%^.*/%%')

# fortran compiler
FC = gfortran
#
# general flags
compile = -c $<
output = -o $@
includes = -I $(INCDIR) -J $(MODDIR)
#
# options
options = -fimplicit-none
warnings = -Wall -Wsurprising -W -pedantic -Warray-temporaries -Wcharacter-truncation	\
-Wimplicit-interface -Wintrinsics-std
debug = -g -fbacktrace -ffpe-trap=invalid,zero,overflow,underflow,denormal
#
# additional opotions for gfortran v4.5 and later
options_new = -std=f2018
warnings_new = -Wconversion-extra -Wimplicit-procedure -Winteger-division -Wreal-q-constant	\
-Wuse-without-only -Wrealloc-lhs-all
debug_new = -fcheck=all
#
# concatonate options
options := $(options) $(options_new)
warnings := $(warnings) $(warnings_new)
debug:= $(debug) $(debug_new)
#
# fortran compiler flags
FCFLAGS = $(includes) $(options) $(warnings)
F77.FLAGS = -fd-lines-as-comments -std=legacy
F90.FLAGS = -std=f2008
FC.COMPILE = $(FC) $(FCFLAGS) $(compile)
FC.COMPILE.o = $(FC.COMPILE)  $(output) $(F77.FLAGS)
FC.COMPILE.o.f90 = $(FC.COMPILE) $(output) $(F90.FLAGS)
FC.COMPILE.mod = $(FC.COMPILE) -o $(OBJDIR)/$*.o $(F90.FLAGS)
#
# fortran linker flags
FLFLAGS = $(output) $^
FC.LINK = $(FC) $(FLFLAGS)
#
# define subdirectories
OBJDIR := obj
MODDIR := mod
BINDIR := bin
INCDIR := inc
VPATH = $(INCDIR)
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
FUNS. = getunit opened
DEPS. = $(MODS.) $(SUBS.) $(FUNS.)

DEPS.o = $(addsuffix .o,$(DEPS.))
OBJS.o = $(filter-out $(DEPS.o),$(OBJS.all))
MODS.mod = $(addsuffix .mod,$(MODS.))

DEPS := $(addprefix $(OBJDIR)/,$(DEPS.o))
OBJS := $(addprefix $(OBJDIR)/,$(OBJS.o))
MODS := $(addprefix $(MODDIR)/,$(MODS.mod))
#
# executables
EXES = $(addprefix $(BINDIR)/,$(OBJS.o:.o=.exe))
#
# sub-programs
SUBDIRS := $(wildcard pi*)

all: $(EXES) $(SUBDIRS)
	@echo "$(THISDIR) $@ done"

$(SUBDIRS):
	@$(MAKE) --no-print-directory -C $@

printvars:
	@echo "printing variables:"
	@echo
	@echo "SUBDIRS = $(SUBDIRS)"
	@echo
	@echo "SRC.F77 = $(SRC.F77)"
	@echo
	@echo "SRC.F90 = $(SRC.F90)"
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
	@echo "compiling specific executable $@..."
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
$(MODDIR)/%.mod: %.f | $(MODDIR) # $(OBJDIR) 
	@echo "\ncompiling generic module $@..."
	$(FC.COMPILE.mod)
$(MODDIR)/%.mod: %.f90 | $(MODDIR) # $(OBJDIR) 
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
.SECONDARY: $(DEPS) $(OBJS) $(MODS)
#
# recipes without outputs
.PHONY: all $(SUBDIRS) mostlyclean clean out realclean distclean

#
# clean up routines
optSUBDIRS = $(addprefix $(MAKE) $@ --no-print-directory -C ,$(addsuffix ;,$(SUBDIRS)))
RM = @rm -vfrd
mostlyclean:
# remove compiled binaries
	@echo "removing compiled binary files..."
	$(RM) $(OBJDIR)/*.o
	$(RM) *.o *.obj
	$(RM) $(MODDIR)/*.mod
	$(RM) *.mod
	$(RM) fort.*
	@$(optSUBDIRS)
	@echo "$@ done"
clean: mostlyclean 
# remove executables
	@echo "\nremoving compiled executable files..."	
	$(RM) $(BINDIR)/*.exe
	$(RM) $(BINDIR)
	$(RM) *.exe
	$(RM) *.out
	$(RM) $(OBJDIR)
	$(RM) $(MODDIR)
	@$(optSUBDIRS)
	@echo "$@ done"
out:
# remove outputs produced by executables
	@echo "\nremoving output files..."
	$(RM) fname*.in
	$(RM) svp.out
	$(RM) svp.in
	$(RM) state
	$(RM) test
	$(RM) test?
	@$(optSUBDIRS)
	@echo "$@ done"
realclean: clean out
# remove binaries and outputs
#	$(MAKE) $@ -C pi
	@$(optSUBDIRS)
	@echo "$@ done"	
distclean: realclean
	@echo "\nremoving backup files..."			
# remove Git versions
	$(RM) *.~*~
# remove Emacs backup files
	$(RM) *~ \#*\#
# clean sub-programs
	@$(optSUBDIRS)
#$(MAKE) $@ -C pi
	@echo "$@ done"
#
# test the makefile
test: distclean printvars all
#
# run executables
run: all # test all functions that run automatically
	$(addprefix ./$(BINDIR)/,$(addsuffix .exe;,\
	ar \
	extrema \
	fmt \
	fun \
	global \
	globsubs \
	hello \
	huge \
	io \
	make_svp \
	test_getunit \
	sign \
	subs \
	sys \
	test_abs \
	test_system_clock \
	timedate \
	units \
	gethost ))
	@$(optSUBDIRS)

run_man: all # test all functions that require manual input
	./$(BINDIR)/ask.exe
	./$(BINDIR)/collatz.exe
	./$(BINDIR)/collatz_glide.exe
	./$(BINDIR)/fundem.exe
	./$(BINDIR)/pause.exe

run_int: all # test all functions that require user interrupt
	./$(BINDIR)/collatz_loop.exe; \
	./$(BINDIR)/interrupt.exe; \
	./$(BINDIR)/timer.exe

run_fmt: all # test all functions that require set_fmt.f
	./$(BINDIR)/collatz.exe
	./$(BINDIR)/collatz_loop.exe; \
	./$(BINDIR)/fmt.exe; \
	./$(BINDIR)/huge.exe; \
	./$(BINDIR)/test_system_clock.exe
