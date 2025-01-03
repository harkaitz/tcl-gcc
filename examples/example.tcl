#!/usr/bin/env tclsh
package require gcc

::gcc::program test1 -files { example.c }
puts [test1]
