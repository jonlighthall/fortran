all: hello.exe fundem.exe ar.exe

hello.exe:
	@echo compiling hello...
	gfortran -o hello.exe hello.f

fundem.exe:
	@echo compiling fundem...
	gfortran -o fundem.exe fundem.f

ar.exe:
	@echo compiling ar...
	gfortran -o ar.exe ar.f

clean:
	@echo removing files...
	rm hello.exe fundem.exe ar.exe
