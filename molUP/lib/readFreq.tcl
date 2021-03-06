package provide readFreq 1.6.5

proc molUP::readFreq {} {
	set molID [lindex $molUP::topMolecule 0]

	set list [list $molID $molUP::path]
	lappend molUP::pathsFreq $list

	molUP::readFreqFile $molUP::path

	#### Create a new tab - Frequency

	$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs add [ttk::frame $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -style molUP.white.TLabel] -text "Frequencies"

	# Frequencies Tab
	place [tablelist::tablelist $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.tableLayer \
			-showeditcursor true \
			-columns {0 "Frequency Number" center 0 "Frequency (cm-1)" center 0 "Infrared" center} \
			-stretch all \
			-background white \
			-yscrollcommand [list $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.yscb set] \
			-xscrollcommand [list $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.xscb set] \
			-selectmode single \
			-height 14 \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 0 -y 0 -width 370 -height 200

	place [ttk::scrollbar $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.yscb \
			-orient vertical \
			-command [list $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.tableLayer yview]\
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 370 -y 0 -width 20 -height 200

	place [ttk::scrollbar $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.xscb \
			-orient horizontal \
			-command [list $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.tableLayer xview]\
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 0 -y 200 -height 20 -width 370

	place [ttk::button $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.clearSelection \
			-text "Stop" \
			-command {molUP::clearSelectionFreq} \
			-style molUP.blue.TButton \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 185 -y 225 -width 80
	
	place [ttk::button $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.play \
			-text "Play" \
			-command {animate forward} \
			-style molUP.blue.TButton \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 5 -y 225 -width 80

	place [ttk::button $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.pause \
			-text "Pause" \
			-command {animate pause} \
			-style molUP.blue.TButton \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 95 -y 225 -width 80

	place [ttk::button $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.loadAll \
			-text "Load All Freqs" \
			-command {molUP::loadAllFreqs} \
			-style molUP.blue.TButton \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 275 -y 225 -width 110

	place [ttk::label $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.animFreq \
			-text "Animation Frequency: " \
			-style molUP.white.TLabel \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 5 -y 265 -width 120

	variable animationFreq 3
	variable displacement 0.015
	variable freqVectorsList {}
	place [scale $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.animFreqSlider \
				-from 1 \
				-to 10 \
				-resolution 1 \
				-variable {molUP::animationFreq} \
				-command {molUP::animateFreq $molUP::freqVectorsList $molUP::animationFreq $molUP::displacement} \
				-orient horizontal \
				-showvalue 0 \
				] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 130 -y 265 -width 255

	place [ttk::label $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.displacement \
			-text "Displacement: " \
			-style molUP.white.TLabel \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 5 -y 300 -width 80

	place [scale $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.displacementSlided \
				-from 0.001 \
				-to 0.050 \
				-resolution 0.001 \
				-variable {molUP::displacement} \
				-command {molUP::animateFreq $molUP::freqVectorsList $molUP::animationFreq $molUP::displacement} \
				-orient horizontal \
				-showvalue 0 \
				] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 90 -y 300 -width 295

	variable showVectors 0
	variable vectorDrawScale 3
	place [ttk::checkbutton $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.showVector \
			-text "Show vectors" \
			-variable {molUP::showVectors} \
			-command {molUP::drawVectors $molUP::freqVectorsList none} \
			-style molUP.white.TCheckbutton \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 5 -y 335 -width 165

	place [ttk::label $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.vectorScaleLabel \
			-text "Scale: " \
			-style molUP.white.TLabel \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 180 -y 335 -width 40

	place [scale $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.vectorScale \
				-from 0.1 \
				-to 10.0 \
				-resolution 0.1 \
				-variable {molUP::vectorDrawScale} \
				-command {molUP::drawVectors $molUP::freqVectorsList} \
				-orient horizontal \
				-showvalue 0 \
				] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 220 -y 335 -width 165

	place [ttk::label $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.changeColorVectorsLabel \
			-text "Color of vectors: " \
			-style molUP.white.TLabel \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 5 -y 370 -width 100

	place [ttk::combobox $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.changeColorVectors \
			-textvariable molUP::freqVectorColor \
			-style molUP.TCombobox \
			-values "$molUP::colorList" \
			-state readonly \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 110 -y 370 -width 275
	bind $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.changeColorVectors <<ComboboxSelected>> {molUP::changeVectorsColor}

	place [ttk::label $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.vectorThresholdLabel \
			-text "Vectors threshold: " \
			-style molUP.white.TLabel \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 5 -y 420 -width 100

	place [scale $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.vectorThreshold \
				-from 0.0 \
				-to 2 \
				-resolution 0.005 \
				-variable {molUP::vectorThreshold} \
				-command {molUP::drawVectors $molUP::freqVectorsList} \
				-orient horizontal \
				-showvalue 1 \
				] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5 -x 110 -y 405 -width 275


	## Add each frequency to the table 
	set freqIndex 0
	foreach line $molUP::freqList lineIR $molUP::irList {
		foreach freq $line ir $lineIR {
			incr freqIndex
			$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.tableLayer insert end [list \
		   			"$freqIndex" \
		   			"$freq" \
					"$ir"
		   			]
		}
	}

	## Run a command when a freq is selected
	bind $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.tableLayer <<TablelistSelect>> {molUP::selectFreq}


	if {[winfo exists $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.energyEntry] != 0} {
		#### Thermal Corrections
		set thermalCorrections [molUP::readThermalCorrections $molUP::path]

		## Add information to energy tab
		set electronicEnergy [$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.energyEntry get 1.0 end]

		set zpEnergy [expr $electronicEnergy + [lindex $thermalCorrections 0]]
		set enthalpy [expr $electronicEnergy + [lindex $thermalCorrections 1]]
		set gibbs [expr $electronicEnergy + [lindex $thermalCorrections 2]]

		place [ttk::label $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.zpEnergyLabel \
			-style molUP.white.TLabel \
			-text {Zero-Point Energy (Hartree)} \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6 -x 10 -y 180 -width 200

		place [text $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.zpEnergy \
			-bd 1 \
			-highlightcolor #017aff \
			-highlightthickness 1 \
			-wrap word \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6 -x 220 -y 180 -width 130 -height 25
		$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.zpEnergy insert end $zpEnergy
		$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.zpEnergy configure -state disabled

		place [ttk::button $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.graph.copyEnergyZP \
			-style molUP.copyButton.TButton \
			-text "Copy to clipboard" \
			-command {molUP::copyClipboardFromText $molUP::topGui.frame0.major.mol[lindex $molUP::topMolecule 0].tabs.tabOutput.tabs.tab6.zpEnergy} \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.graph -x 355 -y 176 -width 20 -height 20
		balloon $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.graph.copyEnergyZP -text "Copy to clipboard"

		place [ttk::label $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.enthalpyLabel \
			-style molUP.white.TLabel \
			-text {Enthalpy (Hartree)} \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6 -x 10 -y 210 -width 200

		place [text $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.enthalpy \
			-bd 1 \
			-highlightcolor #017aff \
			-highlightthickness 1 \
			-wrap word \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6 -x 220 -y 210 -width 130 -height 25
		$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.enthalpy insert end $enthalpy
		$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.enthalpy configure -state disabled

		place [ttk::button $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.graph.copyEnergyenthalpy \
			-style molUP.copyButton.TButton \
			-text "Copy to clipboard" \
			-command {molUP::copyClipboardFromText $molUP::topGui.frame0.major.mol[lindex $molUP::topMolecule 0].tabs.tabOutput.tabs.tab6.enthalpy} \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.graph -x 355 -y 206 -width 20 -height 20
		balloon $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.graph.copyEnergyenthalpy -text "Copy to clipboard"

		place [ttk::label $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.gibbsLabel \
			-style molUP.white.TLabel \
			-text {Gibbs Free Energy (Hartree)} \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6 -x 10 -y 240 -width 200

		place [text $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.gibbs \
			-bd 1 \
			-highlightcolor #017aff \
			-highlightthickness 1 \
			-wrap word \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6 -x 220 -y 240 -width 130 -height 25
		$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.gibbs insert end $gibbs
		$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.gibbs configure -state disabled

		place [ttk::button $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.graph.copyEnergygibbs \
			-style molUP.copyButton.TButton \
			-text "Copy to clipboard" \
			-command {molUP::copyClipboardFromText $molUP::topGui.frame0.major.mol[lindex $molUP::topMolecule 0].tabs.tabOutput.tabs.tab6.gibbs} \
			] -in $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.graph -x 355 -y 236 -width 20 -height 20
		balloon $molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab6.graph.copyEnergygibbs -text "Copy to clipboard"
	}

}


proc molUP::readThermalCorrections {path} {
	set thermalCorrections {}

	catch {exec $molUP::grep -m 1 "Thermal correction to Energy=" $path | $molUP::cut -f2 -d=} zpEnergy
	lappend thermalCorrections $zpEnergy
	catch {exec $molUP::grep -m 1 "Thermal correction to Enthalpy=" $path | $molUP::cut -f2 -d=} enthalpy
	lappend thermalCorrections $enthalpy
	catch {exec $molUP::grep -m 1 "Thermal correction to Gibbs Free Energy=" $path | $molUP::cut -f2 -d=} gibbs
	lappend thermalCorrections $gibbs

	### Return a list containing the thermal corrections for ZPE, Enthalpy and Gibbs Energy, respectively
	return $thermalCorrections

}

proc molUP::readFreqFile {file} { 
	variable freqList {}
	variable freqLine {}
	variable irList {}

	set a [split [exec $molUP::grep -n -m $molUP::nFreqToRead "Frequencies --" $file] "\n"]
	set b [split [exec $molUP::grep -n -m $molUP::nFreqToRead "IR Inten    --" $file] "\n"]

	foreach line  $a {
        	set molUP::freqList [lappend molUP::freqList "[lindex $line 3] [lindex $line 4] [lindex $line 5]"]
        	set molUP::freqLine [lappend molUP::freqLine [lindex [split [lindex $line 0] ":"] 0]]
	}

	foreach line  $b {
        	set molUP::irList [lappend molUP::irList "[lindex $line 4] [lindex $line 5] [lindex $line 6]"]
	}

}

proc molUP::searchFreq {freq_value freq_list freq_line} {

	set line 0
	set answer ""
	foreach a $freq_list {
		set pos [lsearch $a $freq_value]
		if {$pos !=-1} {set answer "$line $pos"}
		incr line 
	}

return $answer
}

proc molUP::extractFreqVectors {file where} {
	if {[lindex $molUP::freqLine [lindex $where 0]] != [expr [lindex $molUP::freqLine [lindex $where 0]] + 30]} {
		catch {exec $molUP::sed -n "[lindex $molUP::freqLine [lindex $where 0]] {p; :loop n; p; [expr [lindex $molUP::freqLine [lindex $where 0]] + 30] q; b loop}" $file | $molUP::grep -n -m 1 "  Atom  AN      X      Y      Z"} a
	} else {
		catch {exec $molUP::sed -n "[lindex $molUP::freqLine [lindex $where 0]] {p; :loop n; q; b loop}" $file | $molUP::grep -n -m 1 "  Atom  AN      X      Y      Z"} a
	}
	set lookUpPos [split $a ":"]

	set numberLines [expr [lindex $molUP::freqLine 1] - [lindex $molUP::freqLine 0]]

	if {[expr [lindex $molUP::freqLine [lindex $where 0]] + [lindex $lookUpPos 0]] != [expr [lindex $molUP::freqLine [expr [lindex $where 0]+1]]-3]} {
		catch {exec $molUP::sed -n "[expr [lindex $molUP::freqLine [lindex $where 0]] + [lindex $lookUpPos 0]] {p; :loop n; p; [expr [lindex $molUP::freqLine [lindex $where 0]] + $numberLines -3] q; b loop}" $file} vectors
	} else {
		catch {exec $molUP::sed -n "[expr [lindex $molUP::freqLine [lindex $where 0]] + [lindex $lookUpPos 0]] {p; :loop n; q; b loop}" $file} vectors
	}
	set vectors_split [split $vectors "\n"]

	set columnX [expr [lindex $where 1] +2 + [lindex $where 1]*2]
	set columnY [expr [lindex $where 1] +3 + [lindex $where 1]*2]
	set columnZ [expr [lindex $where 1] +4 + [lindex $where 1]*2]

	set freq_vector ""
	foreach a $vectors_split {
		if {[lindex $a $columnX] != "0.00" || [lindex $a $columnY] != "0.00" || [lindex $a $columnZ] || "0.00"} {
			set freq_vector [lappend list "[lindex $a 0] [lindex $a $columnX] [lindex $a $columnY] [lindex $a $columnZ]"]
		}
	}

return $freq_vector
}

proc molUP::animateFreq {freqList animationFreq displacement a} {
	# Delete previous animation
	animate delete beg 1 end 9999999 [lindex $molUP::topMolecule 0]

	# Animate stype rock
	animate style Loop

	#Animate Speed
	animate speed 1.00
	animate skip $molUP::animationFreq

	set factor $molUP::displacement


	for {set index 0} { $index < 40 } { incr index } {
		animate dup [lindex $molUP::topMolecule 0]
		foreach freq $freqList {
			set displacement $factor
			set sel [atomselect [lindex $molUP::topMolecule 0] "index [expr [lindex $freq 0] -1 ]"]
			$sel moveby [list "[expr $displacement * [lindex $freq 1]]" "[expr $displacement * [lindex $freq 2]]" "[expr $displacement * [lindex $freq 3]]"]
			$sel delete
		}
	}
	for {set index 0} { $index < 80 } { incr index } {
		animate dup [lindex $molUP::topMolecule 0]
		foreach freq $freqList {
			set displacement -$factor
			set sel [atomselect [lindex $molUP::topMolecule 0] "index [expr [lindex $freq 0] -1 ]"]
			$sel moveby [list "[expr $displacement * [lindex $freq 1]]" "[expr $displacement * [lindex $freq 2]]" "[expr $displacement * [lindex $freq 3]]"]
			$sel delete
		}
	}
	for {set index 0} { $index < 40 } { incr index } {
		animate dup [lindex $molUP::topMolecule 0]
		foreach freq $freqList {
			set displacement $factor
			set sel [atomselect [lindex $molUP::topMolecule 0] "index [expr [lindex $freq 0] -1 ]"]
			$sel moveby [list "[expr $displacement * [lindex $freq 1]]" "[expr $displacement * [lindex $freq 2]]" "[expr $displacement * [lindex $freq 3]]"]
			$sel delete
		}
	}

	animate forward

}

proc molUP::selectFreq {} {
	set molID [lindex $molUP::topMolecule 0]
	
	## Get the list of freq vectors
	set path [lindex [lindex $molUP::pathsFreq [lsearch -index 0 -all $molUP::pathsFreq $molID]] 1]
	
	set indexSelectedAtoms [$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.tableLayer curselection]
	set freqLineTable [$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.tableLayer get $indexSelectedAtoms]
	set freqToSearch [lindex $freqLineTable 1]

	molUP::readFreqFile $path

	set answer [molUP::searchFreq $freqToSearch $molUP::freqList $molUP::freqLine]


	set molUP::freqVectorsList [molUP::extractFreqVectors $path $answer]
	
	## Draw vectors
	molUP::drawVectors $molUP::freqVectorsList none

	## Animate Frequency
	molUP::animateFreq $molUP::freqVectorsList $molUP::animationFreq $molUP::displacement "none"

	# Update frames selector
	$molUP::topGui.frame0.molSelection.framescale configure -to [expr [molinfo top get numframes] -1]
	$molUP::topGui.frame0.molSelection.framescale configure -value [molinfo top get frame]

}

proc molUP::clearSelectionFreq {} {
	# Pause animation
	animate pause

	# Delete previous animation
	animate delete beg 1 end 9999999 [lindex $molUP::topMolecule 0]

	# Delete all vectors
	graphics [lindex $molUP::topMolecule 0] delete all
}

proc molUP::drawVectors {freqList none} {

	if {$molUP::showVectors == 0} {
		graphics [lindex $molUP::topMolecule 0] delete all
		
	} else {

	

	# Delete all vectors
	graphics [lindex $molUP::topMolecule 0] delete all

	graphics [lindex $molUP::topMolecule 0] color $molUP::freqVectorColor
	
	set displacement $molUP::vectorDrawScale
	
	foreach freq $freqList {
			set sel [atomselect [lindex $molUP::topMolecule 0] "index [expr [lindex $freq 0] -1 ]"]
			set x [$sel get x]
			set y [$sel get y]
			set z [$sel get z]
			set atomCoord [list "$x" "$y" "$z"]

			set originalvectorSize [veclength [list "[lindex $freq 1]" "[lindex $freq 2]" "[lindex $freq 3]"]]

			if { $originalvectorSize > $molUP::vectorThreshold } {
				set vectorToScale [vecscale $displacement [list "[lindex $freq 1]" "[lindex $freq 2]" "[lindex $freq 3]"]]

				set lastPoint [vecadd $atomCoord $vectorToScale]
				graphics [lindex $molUP::topMolecule 0] cylinder $atomCoord $lastPoint radius 0.05 resolution 10 filled yes

				set vectorSize [veclength $vectorToScale]
				if {$vectorSize == 0} {
					set factorCone 0
				} else {
					set factorCone [expr 0.2 / $vectorSize]
				}
				
				set vectorCone [vecscale $factorCone $vectorToScale]
				set lastPointCone [vecadd $lastPoint $vectorCone]
				
				graphics [lindex $molUP::topMolecule 0] cone $lastPoint $lastPointCone radius 0.10 resolution 10

			} else {
				#ignore vector
			}


		}

	}
}


proc molUP::changeVectorsColor {} {
	molUP::drawVectors $molUP::freqVectorsList none
}


proc molUP::loadAllFreqs {} {
	## Get Path
	set molID [lindex $molUP::topMolecule 0]
	set path [lindex [lindex $molUP::pathsFreq [lsearch -index 0 -all $molUP::pathsFreq $molID]] 1]

	## Read All Freqs
	set molUP::nFreqToRead 99999999999
	molUP::readFreqFile $path
	set molUP::nFreqToRead 5

	## Delete all content on table
	$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.tableLayer delete anchor end
	
	## Add each frequency to the table 
	set freqIndex 0
	foreach line $molUP::freqList lineIR $molUP::irList {
		foreach freq $line ir $lineIR {
			incr freqIndex
			$molUP::topGui.frame0.major.mol$molID.tabs.tabOutput.tabs.tab5.tableLayer insert end [list \
		   			"$freqIndex" \
		   			"$freq" \
					"$ir"
		   			]
		}
	}
}