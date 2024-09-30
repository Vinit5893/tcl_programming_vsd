#! /bin/env tclsh
# ------------------------------------------------------------------------------ #
# ------Check weather synth is correct or not ---------------------------------- #
# ------------------------------------------------------------------------------ #

set enable_prelayout_timing 1
set working_dir [exec pwd]
set array_length [llength [split [lindex $argv 0] .]]
set input [lindex [split [lindex $argv 0] .] $array_length-1]

if {![regexp {^csv} $input]} {
    puts "Error in Usage ..."
    puts "Usage : ./synth <csv file>"
    puts "where <.csv> files have below inputs ..."
    exit 1
} else {
    set filename [lindex $argv 0]
    package require csv
    package require struct::matrix
    struct::matrix m
    set f [open $filename]
    csv::read2matrix $f m , auto
    close $f
    set columns [m columns]
    # m add columns $columns
    m link my_arr
    set num_of_rows [m rows]
    set i 0
    while {$i < $num_of_rows} {
        puts "\n INFO : Setting $my_arr(0, $i) as $my_arr(1, $i)"
        if {$i == 0}{
            set [string map {" " "_"} $my_arr(0, $i)] $my_arr(1, $i)
        } else {
            set [string map {" " "_"} $my_arr(0, $i)] [file normalize $my_arr(1, $i)]
        }
        incr i
    }
}
 
return

