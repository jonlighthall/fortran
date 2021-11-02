# Fortran 
This repsoitory contains simple programs written as I learn FORTRAN.

## Contents
### Programs
| name                       | description      | command tested | file dependencies | files output
| -------------------------- | ---------------  | ---- | ---- | ---- |
| [`hello.f   `](hello.f   ) | hello world      | `write` `sleep`
| [`fundem.f  `](fundem.f  ) | fundamental      | `read` `function`
| [`ar.f      `](ar.f	   ) | array            | `subroutine` | [`f.f`](f.f) [`f2.f`](f2.f)
| [`global.f  `](global.f  ) | global variable  | `include`|[`araydim.inc`](araydim.inc)
| [`sys.f     `](sys.f	   ) | system           | `system`
| [`subs.f    `](subs.f	   ) | subroutines      | `call` | [`f.f`](f.f) [`f2.f`](f2.f)
| [`globsubs.f`](globsubs.f) | global variable subroutine | `include` `call`|[`araydim.inc`](araydim.inc)
| [`test_abs.f`](test_abs.f) | absolute value   | `abs` `real`
| [`sign.f    `](sign.f    ) | sign control     | `ss` `sp`
| [`io.f      `](io.f      ) | input/output     | `inquire` `open` ||`svp.out`
| [`timedate.f`](timedate.f) | date and time    | `date_and_time`
| [`pause.f`](pause.f)       | pause            | `pause`
| [`test_system_clock.f`](test_system_clock.f)  | system clock | `system_clock`| [`format.f`](format.f) [`set_format.f`](set_format.f)
| [`make_svp.f`](make_svp.f) | make svp           | `system_clock` `srand` `rand`||`svp.in`
| [`collatz.f`](collatz.f)   | Collatz sequence || [`format.f`](format.f) [`set_format.f`](set_format.f)
| [`collatz_loop.f`](collatz_loop.f) | Collatz delay records | | [`format.f`](format.f) [`set_format.f`](set_format.f) | [`collatz.txt`](collatz.out)
| [`collatz_glide.f`](collatz_glide.f)   | Collatz glide calculation || [`format.f`](format.f) [`set_format.f`](set_format.f)
| [`huge.f`](huge.f)         | largest integer  |`kind` `huge` | [`format.f`](format.f) [`set_format.f`](set_format.f)
| [`collatz_loop.f`](collatz_loop.f) | Collatz delay records | | [`format.f`](format.f) [`set_format.f`](set_format.f) | [`collatz.out`](collatz.out)
| [`interrupt.f`](interrupt.f)| catch interrupt signal |`common` `signal`||`state`
| [`extrema.f`](extrema.f)   | extrema          | `huge` `tiny` ||
| [`newunit_test.f`](newunit_test.f)| newunit replacement |`inquire`|[`newunit.f`](newunit.f)|
| [`fmt.f`](fmt.f)| comma format |              | [`format.f`](format.f) [`set_format.f`](set_format.f)|
| [`timer.f`](timer.f)       | timer            | `system_clock` `common` `signal` | [`set_format.f`](set_format.f)
| [`units.f`](units.f)       | unit conversions | `selected_real_kind` |
| [`basel.f`](basel.f)	     | basel problem	|
| [`test_pi.f`](test_pi.f)   | pi		| `atan`
| [`ask.f`](ask.f)	     | read to logical	| `index`
| [`borwein.f`](borwein.f)   | pi iteration	|
| [`leibniz.f`](leibniz.f)   | pi iteration	|
| [`wallis.f`](wallis.f)   | pi iteration	|

### Subroutines
| name                       | description      | command tested | file dependencies | 
| -------------------------- | ---------------  | ---- | ---- | 
| [`f2.f`](f2.f)             |                  | `dimension` |
| [`f.f`](f.f)              |                  | `dimension` |
| [`format.f`](format.f)     | format numerical input to string 

### Functions
| name                       | description      |
| -------------------------- | ---------------- |
| [`newunit.f`](newunit.f)   | new unit replacement |

### Includes
| name                       | description      |
| -------------------------- | ---------------- |
| [`araydim.inc`](araydim.inc) | array dimension
| [`set_format.f`](set_format.f) | set format


## Installation

### Prerequisites

Requies a compiler for Fortran, such as GNU Fortran.
Use the following command to install GFortran, etc, on Linux.
```bash
sudo apt update && sudo apt -y upgrade
sudo apt -y install git
sudo apt -y install make
sudo apt -y install gfortran
```

Use the following commands to install GFortran, etc, on MSYS2.
```bash
pacman -Syu --noconfirm
pacman -S --noconfirm git
pacman -S --noconfirm make
pacman -S --noconfirm mingw32/mingw-w64-i686-gcc-fortran
pacman -S --noconfirm mingw64/mingw-w64-x86_64-gcc-fortran
pacman -S --noconfirm msys/gcc-fortran
```

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

>`make run` to run programs which do not require user input.

>`make run_man` to run programs which require user input.

>`make run_int` to run programs which require an interrupt signal to terminate.
