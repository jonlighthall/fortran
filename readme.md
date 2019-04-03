# Fortran
This repsoitory contains basic programs written in FORTRAN.

## Contents

| program              | description                           | command tested |
| -------------------- | ------------------------------------  | ---- | 
| [`hello.f   `](hello.f   ) | hello world | `print`
| [`fundem.f  `](fundem.f  ) | fundamental | `read` `function`
| [`ar.f      `](ar.f	   ) | array | `subroutine`
| [`global.f  `](global.f  ) | global variable | `include`
| [`sys.f     `](sys.f	   ) | system | `system`
| [`subs.f    `](subs.f	   ) | subroutines | `call`
| [`globsubs.f`](globsubs.f) | global variable | `include` `call`
| [`test_abs.f`](test_abs.f) | absolute value | `abs` `real`
| [`io.f      `](io.f      ) | input/output | `inquire` `open`

## Installation

### Prerequisites

Requies the a compiler for Fortran, such as GNU Fortran.
Use the following command to install GFortran on Linux.

`sudo apt install gfortran`

### Cloning

Check out the folder from the repository with one of the following commands.

`svn co https://github.com/jonlighthall/fortran.git/trunk/ ./fortran` (SVN)

`git clone https://github.com/jonlighthall/fortran` (Git HTTPS)

`git clone git@github.com:jonlighthall/fortran.git` (Git SSH)

## Compiling
Compile the source files and create executables with commands such as the following.

`gfortran -o hello.exe hello.f` 

Alternatively, these commands can be executed by using the `make` command.

## Executing
The compiled executables can be run using commands such as the following.
  
`./hello.exe`
