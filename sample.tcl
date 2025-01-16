

package require Tcl 8.5

# Helper function to generate random hex strings
proc generateHex {length} {
    set hex [format "%0*X" $length [expr {int(rand() * pow(16, $length))}]]
    return $hex
}

# Procedure to populate a 30x3 array
proc populateArray {} {
    global arr
    set arr {}
    for {set i 0} {$i < 30} {incr i} {
        set row {}
        # Generate an 8-character string
        set str [generateHex 10]
        lappend row [format "0x%s" $str]
        # Generate a 40-bit hex number
        set hex40 [generateHex 1]
        lappend row [format "0x%s" $hex40]
        # Generate a 32-bit hex number
        set hex32 [generateHex 8]
        lappend row [format "0x%s" $hex32]
        lappend arr $row
    }
}

# Usage Example
populateArray
puts "Original Array:"
puts $arr
foreach row $arr { puts $row }

# Procedure to sort the array based on the middle element of each row
proc sortArray {} {
    global arr
    if {![info exists arr]} {
        return [-1 -1 -1]
    }
    set sorted [lsort -ascii -index 1 $arr]
    set arr $sorted
}
set sortResult [sortArray]
foreach row $sortResult { puts $row }

# Procedure to select rows by the first element in each row
proc selectRows {value} {
    global arr
    if {![info exists arr]} {
        return [-1 -1 -1]
    }
    set selected {}
    foreach row $arr {
        if {[lindex $row 0] == [format "0x%x" $value]} {
            lappend selected $row
        }
    }
    return $selected
}

set selectedRows [selectRows 0xA]
set selectedRows [selectRows 11]
set selectedRows [selectRows 0xCBD3AFD597]


if {$selectedRows == [-1 -1 -1]} {
    puts "Array is not defined."
} else {
    puts "Selected Rows:"
    puts $selectedRows
}
