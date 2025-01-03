TCL-GCC
=======

Small Tcl/Tk library that builds C/C++ programs and wraps them in procedures.

Example program:

    ----------------------------------------------
    package require gcc 0.1
    
    ::gcc::program test1 -files { example.c }
    puts [test1]
    ----------------------------------------------
    #include <stdio.h>

    int
    main(int _argc, char *_argv[])
    {
            printf("%s", __DATE__);
            return 0;
    }
    ----------------------------------------------

The program is built only once, it is cached based on file modification
times and flags.

## Installation

    make
    sudo make install

## Functions.

    ::gcc::program FUNCNAME [-files { FILES }][-flags { GCC_FLAGS }]
    [-exec { EXEC_FLAGS }]

## Environment variables

- `TCL_GCC_COMPILER` : Compiler to use (by default gcc).
- `TCL_GCC_VERBOSE` : Print to stderr when the compiler is invoked.
- `TCL_GCC_REBUILD` : Build always, do not use the cache.
- `TCL_GCC_CACHE` : Save built programs in this directory.
- `HOME/USERPROFILE` : The programs are saved in `~/.tcl-gcc` by default.

## Collaborating

For making bug reports, feature requests, support or consulting visit
one of the following links:

1. [gemini://harkadev.com/oss/](gemini://harkadev.com/oss/)
2. [https://harkadev.com/oss/](https://harkadev.com/oss/)
