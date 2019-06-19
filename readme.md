# Fortran 
This repsoitory contains basic programs written in FORTRAN.

## Contents

| program              | description                           | command tested | file dependencies | files output
| -------------------- | ------------------------------------  | ---- | ---- | ---- |
| [`hello.f   `](hello.f   ) | hello world | `print`
| [`fundem.f  `](fundem.f  ) | fundamental | `read` `function`
| [`ar.f      `](ar.f	   ) | array | `subroutine` | [`f.f`](f.f) [`f2.f`](f2.f)
| [`global.f  `](global.f  ) | global variable | `include`|[`araydim.inc`](araydim.inc)
| [`sys.f     `](sys.f	   ) | system | `system`
| [`subs.f    `](subs.f	   ) | subroutines | `call` | [`f.f`](f.f) [`f2.f`](f2.f)
| [`globsubs.f`](globsubs.f) | global variable | `include` `call`||[`araydim.inc`](araydim.inc)
| [`test_abs.f`](test_abs.f) | absolute value | `abs` `real`
| [`sign.f    `](sign.f    ) | sign control | `ss` `sp`
| [`io.f      `](io.f      ) | input/output | `inquire` `open` ||`svp.out`
| [`timedate.f`](timedate.f) | date and time | `date_and_time`
| [`pause.f`](pause.f) | pause | `pause`
| [`test_system_clock.f`](test_system_clock.f) | system clock | `system_clock`
| [`make_svp.f`](make_svp.f) |  | `system_clock` `srand` `rand`
| [`collatz.f`](collatz.f) | 
| [`huge.f`](huge.f)||`kind` `huge`
| [`collatz_loop.f`](collatz_loop.f) |  | | | [`collatz.out`](collatz.out)
| [`interrupt.f`](interrupt.f)| |`common` `signal`||`state`

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
