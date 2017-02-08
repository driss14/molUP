package provide saveFiles 1.0

proc molUP::savePDB {} {
    
    set molExists [mol list]
    
    if {$molExists == "ERROR) No molecules loaded."} {
        set alert [tk_messageBox -message "No molecules loaded." -type ok -icon error]
    } else {

        set fileTypes {
                {{PDB (.pdb)}       {.pdb}        }
        }
        set path [tk_getSaveFile -filetypes $fileTypes -defaultextension ".pdb"]

        if {$path != ""} {
            animate write pdb [list $path] beg 0 end 0 skip 1 top
        } else {}
    }

    destroy $::molUP::saveFile
}


proc molUP::saveXYZ {} {
    
    set molExists [mol list]
    
    if {$molExists == "ERROR) No molecules loaded."} {
        set alert [tk_messageBox -message "No molecules loaded." -type ok -icon error]
    } else {

        set fileTypes {
                {{XYZ (.xyz)}       {.xyz}        }
        }
        set path [tk_getSaveFile -filetypes $fileTypes -defaultextension ".xyz"]

        if {$path != ""} {
            animate write xyz [list $path] beg 0 end 0 skip 1 top
        } else {}
    }

    destroy $::molUP::saveFile
}

proc molUP::saveGaussian {} {
    
    set molExists [mol list]
    
    if {$molExists == "ERROR) No molecules loaded."} {
        set alert [tk_messageBox -message "No molecules loaded." -type ok -icon error]
    } else {

        set fileTypes {
                {{Gaussian Input File (.com)}       {.com}        }
        }
        set path [tk_getSaveFile -title "Save file as Gaussian Input" -filetypes $fileTypes -defaultextension ".com"]

        if {$path != ""} {
            molUP::writeGaussianFile $path
        } else {}

    }

    destroy $::molUP::saveFile

}

proc molUP::writeGaussianFile {path} {
    ## Create a file 
	set file [open "$path" w]

    set molID [molinfo top]


    set keywords [.molUP.frame0.major.mol$molID.tabs.tabInput.keywordsText get 1.0 end]
    set title [.molUP.frame0.major.mol$molID.tabs.tabInput.jobTitleEntry get 1.0 end]

    ## Write keywords
    puts $file "$keywords"

    ## Write title
    puts $file "$title"

    ## Write Charge and Multi
    puts $file "$molUP::chargesMultip"

    ## Get coordinates
    set allSelection [atomselect top "all"]
    set allCoord [$allSelection get {x y z}]
    set elementInfo [$allSelection get element]

    ## Get Layer Info
    set layerInfoList [.molUP.frame0.major.mol$molID.tabs.tabResults.tabs.tab2.tableLayer get 0 end]

    ## Get Freeze Info
    set freezeInfoList [.molUP.frame0.major.mol$molID.tabs.tabResults.tabs.tab3.tableLayer get 0 end]
    
    ## Get Charges Info
    set chargesInfoList [.molUP.frame0.major.mol$molID.tabs.tabResults.tabs.tab4.tableLayer get 0 end]

    ## Add link atoms (hydrogens)
    molUP::linkAtoms

    ## Write on the file
    set i 0
    foreach atomLayer $layerInfoList atomFreeze $freezeInfoList atomCharge $chargesInfoList atomCoord $allCoord element $elementInfo {
        set lookForLinkAtom [lsearch $molUP::linkAtomsListIndex $i]

        set xx [lindex $atomCoord 0]
        set yy [lindex $atomCoord 1]
        set zz [lindex $atomCoord 2]

        if {$lookForLinkAtom == -1} {
            set initialInfo " $element-[lindex $atomCharge 1]-[lindex $atomCharge 4](PDBName=[lindex $atomLayer 1],ResName=[lindex $atomLayer 2],ResNum=[lindex $atomLayer 3])"
            puts $file "[format %-60s $initialInfo] [format %-4s [lindex $atomFreeze 4]] [format "%10s" [format "% f" $xx]] [format "%10s" [format "% f" $yy]] [format "%10s" [format "% f" $zz]] [format %-2s [lindex $atomLayer 4]]"
        } else {
            set linkAtom [lindex $molUP::linkAtomsList $lookForLinkAtom]

            set initialInfo " [string range [lindex $atomCharge 1] 0 0]-[lindex $atomCharge 1]-[lindex $atomCharge 4](PDBName=[lindex $atomLayer 1],ResName=[lindex $atomLayer 2],ResNum=[lindex $atomLayer 3])"
            puts $file "[format %-60s $initialInfo] [format %-4s [lindex $atomFreeze 4]] [format "%10s" [format "% f" $xx]] [format "%10s" [format "% f" $yy]] [format "%10s" [format "% f" $zz]] [format %-2s [lindex $atomLayer 4]]$linkAtom"
        }
    
        incr i
    }

    set connectivity [.molUP.frame0.major.mol$molID.tabs.tabInput.connect get 1.0 end]
    puts $file "\n$connectivity"

    set parameters [.molUP.frame0.major.mol$molID.tabs.tabInput.param get 1.0 end]
    puts $file "$parameters"

    close $file

}

proc molUP::connectivityFromVMD {} {
    set list [topo getbondlist order]
    set connectivity ""
    set numberAtoms [[atomselect top all] num]

    for {set index 1} { $index <= $numberAtoms } { incr index } {
        append connectivity " $index"
        
        set a [lsearch -index 0 -all $list "[expr $index -1]"]

        if {$a != ""} {
            foreach b $a {
                set atom [expr [lindex [lindex $list $b] 1] + 1]
                set order [lindex [lindex $list $b] 2]

                append connectivity " $atom $order"
            }
        } else {}
    
    append connectivity "\n"

    }

    return $connectivity
}


proc molUP::convertGaussianInputConnectToVMD {connectivityList} {
    set connectivity {}
    
    set connectivityList [split $connectivityList "\n"]

    foreach line $connectivityList {
        set lineLength [llength $line]
        if {$lineLength > 1} {
            set numberBonds [expr ($lineLength - 1) / 2]
            set atom1 [expr [lindex $line 0] -1]
            for {set index 1} { $index <= $numberBonds } { incr index } {
                set atom2 [expr [lindex $line [expr $index * 2 - 1]] -1]
                set order [lindex $line [expr $index * 2]]
                lappend connectivity [list $atom1 $atom2 $order]
            }
        }
    }
    return $connectivity
}

proc molUP::linkAtoms {} {
    set connectivity [topo getbondlist]
    set molUP::linkAtomsListIndex {}
    set molUP::linkAtomsList {}

    foreach bond $connectivity {

        set layer1 [$molUP::tableLayer get [lindex $bond 0]]
        set layer2 [$molUP::tableLayer get [lindex $bond 1]]

        if {[lindex $layer1 4] == [lindex $layer2 4]} {
            # Do Nothing
        } elseif {[lindex $layer1 4] == "L" && [lindex $layer2 4] == "H"} {
                lappend molUP::linkAtomsListIndex [lindex $bond 0]
                #set atomSymbol [string range [lindex $layer1 1] 0 0]
                set atomNumber [lindex $bond 1]
                lappend molUP::linkAtomsList "H [expr $atomNumber + 1]   0.0000"
        } elseif {[lindex $layer1 4] == "H" && [lindex $layer2 4] == "L"} {
                lappend molUP::linkAtomsListIndex [lindex $bond 1]
                #set atomSymbol [string range [lindex $layer1 1] 0 0]
                set atomNumber [lindex $bond 0]
                lappend molUP::linkAtomsList "H [expr $atomNumber + 1]   0.0000"
        }
    }
}