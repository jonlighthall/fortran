THISDIR=$(shell \pwd | sed 's%^.*/%%')

# fortran compiler
FC = gfortran
#
# general flags
compile = -c $<
output = -o $@
includes = -I $(INCDIR)
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
MODS. = 
SUBS. = 
FUNS. = 
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

all: $(EXES)
	@echo "$(THISDIR) $@ done"
#
# specific recipes
$(BINDIR)/basel.exe: $(OBJDIR)/basel.o | $(BINDIR)
	@echo "compiling specific executable $@..."
	$(FC.LINK) -fdefault-real-8 -fdefault-integer-8
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
.PHONY: mostlyclean clean out realclean distclean
#
# clean up routines
RM = @rm -vfrd
mostlyclean:
# remove compiled binaries
	@echo "removing compiled binary files..."
	$(RM) $(OBJDIR)/*.o
	$(RM) *.o *.obj
	$(RM) $(MODDIR)/*.mod
	$(RM) *.mod
	$(RM) fort.*
	@echo "$(THISDIR) $@ done"
clean: mostlyclean
# remove executables
	@echo "\nremoving compiled executable files..."	
	$(RM) $(BINDIR)/*.exe
	$(RM) $(BINDIR)
	$(RM) *.exe
	$(RM) *.out
	$(RM) $(OBJDIR)
	$(RM) $(MODDIR)
	@echo "$(THISDIR) $@ done"
out:
# remove outputs produced by executables
	@echo "\nremoving output files..."
	@echo "$(THISDIR) $@ done"
realclean: clean out
# remove binaries and outputs
	@echo "$(THISDIR) $@ done"	
distclean: realclean
	@echo "\nremoving backup files..."			
# remove Git versions
	$(RM) *.~*~
# remove Emacs backup files
	$(RM) *~ \#*\#
	@echo "$(THISDIR) $@ done"
#
# test the makefile
test: distclean all
	@echo "$(THISDIR) $@ done"
#
# run executables
run: all
# run executables which do no require user input
	./$(BINDIR)/basel.exe
	./$(BINDIR)/borwein.exe
	./$(BINDIR)/leibniz.exe
	./$(BINDIR)/test_pi.exe
	./$(BINDIR)/wallis.exe
	./$(BINDIR)/pi_monte_carlo.exe
