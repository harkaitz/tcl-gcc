.POSIX:
.SUFFIXES:
.PHONY: all clean install check

PROJECT    =tcl-gcc
VERSION    =1.0.0
TCLSH      =tclsh
PROGS      =
PREFIX     =/usr/local
BUILDDIR  ?=.build
UNAME_S   ?=$(shell uname -s)
EXE       ?=$(shell uname -s | awk '/Windows/ || /MSYS/ || /CYG/ { print ".exe" }')
TCL_SOURCES=

all:
clean:
install:
check:
## -- BLOCK:license --
install: install-license
install-license: README.md COPYING COPYRIGHT
	mkdir -p $(DESTDIR)$(PREFIX)/share/doc/$(PROJECT)
	cp README.md COPYING COPYRIGHT $(DESTDIR)$(PREFIX)/share/doc/$(PROJECT)
## -- BLOCK:license --
## -- BLOCK:tcl --
all: all-tcl
install: install-tcl
uninstall: uninstall-tcl
all-tcl: pkgIndex.tcl
pkgIndex.tcl: $(TCL_SOURCES) $(TCL_SHARED_LIBS)
	@mkdir -p $(BUILDDIR)
	echo 'pkg_mkIndex . $(TCL_SOURCES) $(TCL_SHARED_LIBS)' > $(BUILDDIR)/pkgIndex.tcl.sh
	tclsh $(BUILDDIR)/pkgIndex.tcl.sh
	rm -f $(BUILDDIR)/pkgIndex.tcl.sh
install-tcl:
	mkdir -p $(DESTDIR)$(PREFIX)/share/tcltk/$(PROJECT)
	cp pkgIndex.tcl $(TCL_SOURCES) $(TCL_SHARED_LIBS) $(TCL_IFILES) $(DESTDIR)$(PREFIX)/share/tcltk/$(PROJECT)
uninstall-tcl:
	rm -rf $(DESTDIR)$(PREFIX)/share/tcltk/$(PROJECT)
## -- BLOCK:tcl --
