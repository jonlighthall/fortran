# Fortran 
This subdirectory contains programs written in FORTRAN related to calculating pi.

## Contents
### Programs
| name                       | description      | command tested | file dependencies | files output
| -------------------------- | ---------------  | ---- | ---- | ---- |
| [`basel`] (basel.f) ||
| [`borwein`] (borwein.f) | pi iteration	|
| [`inc/pi_string`] (inc/pi_string.f) | string pi |
| [`leibniz`] (leibniz.f) | pi iteration	|
| [`test_pi.f`](test_pi.f)   | pi		| `atan`
| [`wallis`] (wallis.f) | pi iteration	|

## Installation

### Compiling
Compile the source files and create executables with commands such as the following.

`gfortran -o test_pi.exe test_pi.f` 

Alternatively, these commands can be executed by using the `make` command.

## Execution
The compiled executables can be run using commands such as the following.
  
>`./test_pi.exe`

Groups of executeables can be run in sequnece with the following commands.

>`make run` to run programs which do not require user input.
