all: hello.exe fundem.exe ar.exe global.exe

hello.exe: hello.f
	@echo compiling hello...
	gfortran -o hello.exe hello.f

fundem.exe:
	@echo compiling fundem...
	gfortran -o fundem.exe fundem.f

ar.exe:
	@echo compiling ar...
	gfortran -o ar.exe ar.f

global.exe: global.f araydim.inc
	gfortran global.f -o $@

clean:
	@echo removing files...
	rm hello.exe fundem.exe ar.exe