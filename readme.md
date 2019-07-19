# Fortran 
This repsoitory contains basic programs written in FORTRAN.

## Contents

| program              | description                           | command tested | file dependencies | files output
| -------------------- | ------------------------------------  | ---- | ---- | ---- |
| [`hello.f   `](hello.f   ) | hello world | `write` `sleep`
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
| [`test_system_clock.f`](test_system_clock.f) | system clock | `system_clock`| [`format.f`](format.f)
| [`make_svp.f`](make_svp.f) | | `system_clock` `srand` `rand`||`svp.in`
| [`collatz.f`](collatz.f) | Collatz sequence 
| [`huge.f`](huge.f)| largest integer |`kind` `huge` | [`format.f`](format.f)
| [`collatz_loop.f`](collatz_loop.f) | Collatz delay records | | [`format.f`](format.f) | [`collatz.out`](collatz.out)
| [`interrupt.f`](interrupt.f)| catch interrupt signal |`common` `signal`||`state`
| [`extrema.f`](extrema.f)||||
| [`newunit_test.f`](newunit_test.f)| newunit replacement |`inquire`|[`newunit.f`](newunit.f)|
| [`fmt.f`](fmt.f)| comma format | | [`format.f`](format.f) |
| [`timer.f`](timer.f)| timer | `system_clock` `common` `signal` |

## Installation

### Prerequisites

Requies the a compiler for Fortran, such as GNU Fortran.
Use the following command to install GFortran on Linux.

`sudo apt install gfortran`

### Cloning

Check out the folder from the repository with one of the following commands.

>`svn co https://github.com/jonlighthall/fortran.git/trunk/ ./fortran` (SVN)

>`git clone https://github.com/jonlighthall/fortran` (Git HTTPS)

>`git clone git@github.com:jonlighthall/fortran.git` (Git SSH)

## Compiling
Compile the source files and create executables with commands such as the following.

`gfortran -o hello.exe hello.f` 

Alternatively, these commands can be executed by using the `make` command.

## Executing
The compiled executables can be run using commands such as the following.
  
`./hello.exe`

Groups of executeables can be run in sequnece with the following commands.

>`make test_auto` to run programs which do not require user input.

>`make test_man` to run programs which require user input.

>`make test_int` to run programs which require an interrupt signal to terminate.
