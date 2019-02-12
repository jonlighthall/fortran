all: hello.exe

hello.exe:
	@echo compiling hello...
	gfortran -o hello.exe hello.f

clean:
	@echo removing files...
	rm hello.exe
