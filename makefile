all: hello.exe fundem.exe ar.exe global.exe sys.exe

hello.exe: hello.f
	@echo compiling hello...
	gfortran $^ -o $@

fundem.exe: fundem.f
	@echo compiling fundem...
	gfortran $^ -o $@

ar.exe: ar.f
	@echo compiling ar...
	gfortran $^ -o $@

global.exe: global.f araydim.inc
	gfortran global.f -o $@

sys.exe: sys.f
	gfortran $^ -o $@

clean:
	@echo removing files...
	rm *.exe
	rm *.o