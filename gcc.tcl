package provide gcc 0.1
package require md5 2.0.7

namespace eval ::gcc {

    proc program { name args } {
        global env
        set files [list]
        set flags [list]
        set execs [list]
        set idir  [file dirname [info script]]
        if {[info exists env(TCL_GCC_COMPILER)]} {
            set cc $env(TCL_GCC_COMPILER)
        } else {
            set cc { gcc }
        }
        foreach {key val} $args {
            switch $key {
                -files { foreach f $val { lappend files [file join $idir $f] } }
                -flags { lappend flags {*}$val }
                -exec  { lappend execs {*}$val }
                -*     { error "Unsupported: $key" }
            }
        }
        set prog [program_name $files $flags $execs]
        if {![file exists $prog] || [info exists env(TCL_GCC_REBUILD)]} {
            if {[info exists env(TCL_GCC_VERBOSE)]} {
                puts stderr [list {*}$cc -o $prog {*}$files {*}$flags]
            }
            exec {*}$cc -o $prog {*}$files {*}$flags
        }
        set code [list exec {*}$execs $prog]
        set code [list proc $name { args } "$code {*}\$args"]
        uplevel 1 $code
    }

    proc cachedir { } {
        global env
        set ret {}
        if {[info exists env(TCL_GCC_CACHE)]} {
            set ret $env(TCL_GCC_CACHE)
        } elseif {[info exists env(HOME)]} {
            set ret [file join $env(HOME) .tcl-gcc]
        } elseif {[info exists env(USERPROFILE)]} {
            set ret [file join $env(USERPROFILE) .tcl-gcc]
        } else {
            error "Could not determine TCL-GCC cache directory."
        }
        file mkdir $ret
        return $ret
    }

    proc program_name { ifiles args } {
        set data [list]
        foreach ifile [lsort $ifiles] {
            lappend data [file mtime $ifile] $ifile
        }
        lappend data {*}$args
        set md5 [string range [::md5::md5 -hex $data] 0 10]
        return [file join [cachedir] $md5.exe]
    }
    
    
}
