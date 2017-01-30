all: c.exe f.exe

c.exe:
	g++ -o c.exe hello.c
f.exe:
	gfortran -o f.exe hello.f
