THISDIR=$(shell \pwd | sed 's%^.*/%%')

# fortran compiler
FC = gfortran
#
# general flags
compile = -c $<
output = -o $@
#
# options
options = -fimplicit-none
warnings = -W -Wall -Warray-temporaries -Wcharacter-truncation -Wfatal-errors	\
-Wimplicit-interface -Wintrinsics-std -Wsurprising -Wuninitialized -pedantic
debug = -g -fbacktrace -ffpe-trap=invalid,zero,overflow,underflow,denormal
#
# additional options for gfortran v4.5 and later
options_new = -std=f2018
warnings_new = -Wconversion-extra -Wimplicit-procedure -Winteger-division -Wreal-q-constant \
-Wrealloc-lhs-all -Wuse-without-only
debug_new = -fcheck=all
#
# concatenate options
options := $(options) $(options_new)
warnings := $(warnings) $(warnings_new)
debug := $(debug) $(debug_new)
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
BINDIR := bin
OBJDIR := obj
MODDIR := mod
INCDIR := inc

# add INCDIR if present
ifneq ("$(strip $(wildcard $(INCDIR)))","")
	VPATH = $(INCDIR)
	includes = -I $(INCDIR)
endif
#
# source file lists
#
# program files (executable)
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

# add MODDIR to includes if MODS. not empty
ifneq ("$(strip $(wildcard $(MODS.)))","")
	includes:=$(includes) -J $(MODDIR)
endif

DEPS.o = $(addsuffix .o,$(DEPS.))
OBJS.o = $(filter-out $(DEPS.o),$(OBJS.all))
MODS.mod = $(addsuffix .mod,$(MODS.))

DEPS := $(addprefix $(OBJDIR)/,$(DEPS.o))
OBJS := $(addprefix $(OBJDIR)/,$(OBJS.o))
MODS := $(addprefix $(MODDIR)/,$(MODS.mod))
#
# executables
EXES = $(addprefix $(BINDIR)/,$(OBJS.o:.o=))
#
# sub-programs
SUBDIRS :=
#
# recipes
all: $(EXES) $(SUBDIRS)
	@echo "$(THISDIR) $@ done"

$(SUBDIRS):
	@$(MAKE) --no-print-directory -C $@
#
# specific recipes
$(BINDIR)/basel: $(OBJDIR)/basel.o | $(BINDIR)
	@echo "compiling specific executable $@..."
	$(FC.LINK) -fdefault-real-8 -fdefault-integer-8
#
# generic recipes
$(BINDIR)/%: $(OBJDIR)/%.o $(DEPS) | $(BINDIR)
	@/bin/echo -e "\nlinking generic executable $@..."
	$(FC.LINK)
$(OBJDIR)/%.o: %.f $(MODS) | $(OBJDIR)
	@/bin/echo -e "\ncompiling generic object $@..."
	$(FC.COMPILE.o)
$(OBJDIR)/%.o: %.f90 $(MODS) | $(OBJDIR)
	@/bin/echo -e "\ncompiling generic f90 object $@..."
	$(FC.COMPILE.o.f90)
$(MODDIR)/%.mod: %.f | $(MODDIR)
	@/bin/echo -e "\ncompiling generic module $@..."
	$(FC.COMPILE.mod)
$(MODDIR)/%.mod: %.f90 | $(MODDIR)
	@/bin/echo -e "\ncompiling generic f90 module $@..."
	$(FC.COMPILE.mod)
#
# define directory creation
$(BINDIR):
	@mkdir -v $(BINDIR)
$(OBJDIR):
	@mkdir -v $(OBJDIR)
$(MODDIR):
ifeq ("$(wildcard $(MODS))",)
	@echo "no modules specified"
else
	@echo "creating $(MODDIR)..."
	@mkdir -v $(MODDIR)
endif

# keep intermediate object files
.SECONDARY: $(DEPS) $(OBJS) $(MODS)
#
# recipes without outputs
.PHONY: all $(SUBDIRS) mostlyclean clean out realclean distclean
#
# clean up
optSUBDIRS = $(addprefix $(MAKE) $@ --no-print-directory -C ,$(addsuffix ;,$(SUBDIRS)))
RM = @rm -vfrd
mostlyclean:
# remove compiled binaries
	@echo "removing compiled binary files..."
	$(RM) $(OBJDIR)/*.o
	$(RM) $(OBJDIR)
	$(RM) *.o *.obj
	$(RM) $(MODDIR)/*.mod
	$(RM) $(MODDIR)
	$(RM) *.mod
	$(RM) fort.*
	@$(optSUBDIRS)
	@echo "$(THISDIR) $@ done"
clean: mostlyclean
# remove binaries and executables
	@/bin/echo -e "\nremoving compiled executable files..."
	$(RM) $(BINDIR)/*
	$(RM) $(BINDIR)
	$(RM) *.exe
	$(RM) *.out
	@$(optSUBDIRS)
	@echo "$(THISDIR) $@ done"
out:
# remove outputs produced by executables
	@/bin/echo -e "\nremoving output files..."
	@$(optSUBDIRS)
	@echo "$(THISDIR) $@ done"
realclean: clean out
# remove binaries and outputs
	@/bin/echo -e "\nremoving binary and output files..."
	@$(optSUBDIRS)
	@echo "$(THISDIR) $@ done"
distclean: realclean
# remove binaries, outputs, and backups
	@/bin/echo -e "\nremoving backup files..."
# remove Git versions
	$(RM) *.~*~
# remove Emacs backup files
	$(RM) *~ \#*\#
# clean sub-programs
	@$(optSUBDIRS)
	@echo "$(THISDIR) $@ done"
#
# test
test: distclean all
# test the makefile
	@echo "$(THISDIR) $@ done"
#
# run executables
run: all
# run executables which do no require user input
	$(addprefix ./$(BINDIR)/,\
	basel \
	borwein \
	leibniz \
	test_pi \
	wallis \
	pi_monte_carlo )
	@$(optSUBDIRS) 
