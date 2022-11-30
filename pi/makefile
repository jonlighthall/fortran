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
debug = -g -fbacktrace -fcheck=all			\
-ffpe-trap=invalid,zero,overflow,underflow,denormal
#
# fortran compile flags
FCFLAGS = $(compile) $(options) $(warnings)
F77.FLAGS = -fd-lines-as-comments
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

all: $(EXES) $(OBJS) $(DEPS) $(MODS)
	@echo "$@ done"
#
# specific recipes
$(BINDIR)/basel.exe: $(OBJDIR)/basel.o | $(BINDIR)
	@echo "compiling specific executable $@..."
	$(FC.LINK) -fdefault-real-8 -fdefault-integer-8
#
# generic recipies
$(BINDIR)/%.exe: $(OBJDIR)/%.o $(DEPS) | $(BINDIR)
	@echo -e "\nlinking generic executable $@..."
	$(FC.LINK)	
$(OBJDIR)/%.o: %.f $(MODS) | $(OBJDIR)
	@echo -e "\ncompiling generic object $@..."
	$(FC.COMPILE.o)
$(OBJDIR)/%.o: %.f90 $(MODS) | $(OBJDIR)
	@echo -e "\ncompiling generic f90 object $@..."
	$(FC.COMPILE.o.f90)
$(MODDIR)/%.mod: %.f | $(OBJDIR) $(MODDIR)
	@echo -e "\ncompiling generic module $@..."
	$(FC.COMPILE.mod)
$(MODDIR)/%.mod: %.f90 | $(OBJDIR) $(MODDIR)
	@echo -e "\ncompiling generic f90 module $@..."
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
.PHONY: clean 
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
	@echo "$@ done"
out: 
	@echo "$@ done"
distclean: clean out
# remove Git versions
	$(CMD) *.~*~
# remove Emacs backup files
	$(CMD) *~ \#*\#
	@echo "$@ done"
#
# test the makefile
test: clean all
	@echo "$@ done"
#
# run executables
run: all # test all functions that run automatically
	./basel.exe
	./borwein.exe
	./leibniz.exe
	./test_pi.exe
	./wallis.exe
