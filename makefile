# fortran compiler
FC = gfortran
#
# general flags
compile_flags = -c $<
output_flags = -o $@
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
FC.COMPILE = $(FC) $(compile_flags) $(includes) $(options) $(warnings) $(output_flags) 
FC.COMPILE.o = $(FC.COMPILE) -fd-lines-as-comments
FC.COMPILE.o.f90 = $(FC.COMPILE) $(debug)
#
# fortran link flags
flink = $(output_flags) $^ $(includes)
FC.LINK = $(FC) $(flink)
#
# define subdirectories
OBJDIR := obj
MODDIR := mod
BINDIR := bin
INCDIR := inc
#
# source files
SRC77 = $(wildcard *.f) 
SRC90 = $(wildcard *.f90)
SRC = $(SRC77) $(SRC90)
#
# objects
OBJS77 = $(SRC77:.f=.o)
OBJS90 = $(SRC90:.f90=.o)
OBJS = $(OBJS77) $(OBJS90)
#
# dependencies
MODS = version
SUBS = f2 f format
FUNS = getunit
DEPS = $(MODS) $(SUBS) $(FUNS)
DEPS.o = $(addsuffix .o,$(DEPS))
OBJS.exe = $(filter-out $(DEPS.o),$(OBJS))

OBJS.dir := $(addprefix $(OBJDIR)/,$(OBJS))
DEPS.dir := $(addprefix $(OBJDIR)/,$(DEPS.o))
MODS := $(addprefix $(MODDIR)/,$(addsuffix .mod,$(MODS)))
EXES = $(addprefix $(BINDIR)/,$(OBJS.exe:.o=.exe))

#all: 
all: distclean
	@echo $(SRC)
	@echo
	@echo $(OBJS)
	@echo
	@echo $(DEPS.o)
	@echo
	@echo $(OBJS.exe)	
	@echo
	@echo $(OBJS.dir)	
	@echo
	@echo $(DEPS.dir)	
	@echo
	@echo $(MODS)	
	@echo
	@echo $(EXES)	

exe: $(EXES) | $(DEPS.dir) 

#
# special recipies
$(BINDIR)/ar.exe: $(OBJDIR)/ar.o | $(BINDIR)
	@echo "compiling special executable $@..."
	$(FC.LINK)
#
# general recipies
$(OBJDIR)/%.o: %.f | $(OBJDIR)
	@echo "compiling object $@..."
	$(FC.COMPILE.o)

$(OBJDIR)/%.o: %.f90 | $(OBJDIR)
	@echo "compiling f90 object $@..."
	$(FC.COMPILE.o.f90)

$(OBJDIR)/%.o: $(INCDIR)/%.f | $(OBJDIR) $(MODDIR)
	@echo "compiling include object $@..."
	$(FC.COMPILE.o)

$(OBJDIR)/%.o: $(INCDIR)/%.f90 | $(OBJDIR)
	@echo "compiling include f90 object $@..."
	$(FC.COMPILE.o.f90)

$(BINDIR)/%.exe: $(OBJDIR)/%.o $(DEPS.dir) | $(BINDIR)
	@echo "compiling executable $@..."
	$(FC.LINK)	
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
CMD = @rm -vfrd
clean:
	@echo removing files...	
# remove compiled binaries
	$(CMD) $(TARGET)
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
distclean: clean
	$(CMD) fname*.in
	$(CMD) svp.out
	$(CMD) svp.in
	$(CMD) state
	$(CMD) test
	$(CMD) test?
# remove Git versions
	$(CMD) *.~*~
# remove Emacs backup files
	$(CMD) *~ \#*\#

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
