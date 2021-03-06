package provide guiMolUP 1.6.0

proc molUP::buildGui {} {

	#### Window Configuration ##########################################

	#### Check if the window exists
	if {[winfo exists $::molUP::topGui]} {wm deiconify $::molUP::topGui ;return $::molUP::topGui}
	toplevel $::molUP::topGui

	#### Title of the windows
	wm title $molUP::topGui "molUP v$molUP::version " ;

	#### Change the location of window
	set sWidth [expr [winfo vrootwidth  $::molUP::topGui] -0]
	set sHeight [expr [winfo vrootheight $::molUP::topGui] -100]

	## window width and height
	set wWidth [winfo reqwidth $::molUP::topGui]
	set wHeight [winfo reqheight $::molUP::topGui]
	
	display reposition 0 [expr ${sHeight} - 15]
	display resize [expr $sWidth - 400] ${sHeight}

	set x [expr $sWidth - 2*($wWidth)]

	wm geometry $::molUP::topGui 400x$sHeight+$x+25
	$::molUP::topGui configure -background {white}
	wm resizable $::molUP::topGui 0 0

	## Procedure when the window is closed
	wm protocol $::molUP::topGui WM_DELETE_WINDOW {molUP::quit}

	## Apply theme
	ttk::style theme use molUPTheme
	


	####################################################################################################################
	####################################################################################################################
	####################################################################################################################




	#### Background ##########################################
	pack [ttk::frame $molUP::topGui.frame0]
	

	## Top Menu Bar ##########################################
	pack [canvas $molUP::topGui.frame0.topSection -bg #ededed -width 400 -height 50 -highlightthickness 0] -in $molUP::topGui.frame0 
	place [ttk::frame $molUP::topGui.frame0.topSection.topMenu -width 400 -style molUP.menuBar.TFrame] -in $molUP::topGui.frame0.topSection -x 0 -y 0 -width 400 -height 35
	
	place [ttk::menubutton $molUP::topGui.frame0.topSection.topMenu.file -text "File" -menu $molUP::topGui.frame0.topSection.topMenu.file.menu \
			-style molUP.menuBar.TMenubutton \
			] -in $molUP::topGui.frame0.topSection.topMenu -x 5 -y 5 -height 25 -width 50  
	menu $molUP::topGui.frame0.topSection.topMenu.file.menu -tearoff 0
	$molUP::topGui.frame0.topSection.topMenu.file.menu add command -label "Open" -command {molUP::guiOpenFile}
	$molUP::topGui.frame0.topSection.topMenu.file.menu add command -label "Open Multiple Files" -command {molUP::guiOpenMultiFile}
	$molUP::topGui.frame0.topSection.topMenu.file.menu add command -label "Save" -command {molUP::guiSaveFile}
	#$molUP::topGui.frame0.topSection.topMenu.file.menu add command -label "Close" -command {molUP::quit}
	#$molUP::topGui.frame0.topSection.topMenu.file.menu add command -label "Close VMD" -command {exec exit}

	place [ttk::menubutton $molUP::topGui.frame0.topSection.topMenu.tools -text "Tools" -menu $molUP::topGui.frame0.topSection.topMenu.tools.menu \
			-style molUP.menuBar.TMenubutton \
			] -in $molUP::topGui.frame0.topSection.topMenu -x 54 -y 5 -height 25 -width 60
	menu $molUP::topGui.frame0.topSection.topMenu.tools.menu -tearoff 0
	$molUP::topGui.frame0.topSection.topMenu.tools.menu add command -label "Measure Bonds, Angles, and Dihedral" -command {molUP::badParams}
	$molUP::topGui.frame0.topSection.topMenu.tools.menu add command -label "Reset view" -command {display resetview}
	$molUP::topGui.frame0.topSection.topMenu.tools.menu add command -label "Center atom" -command {mouse mode center}
	$molUP::topGui.frame0.topSection.topMenu.tools.menu add command -label "Delete all labels" -command {molUP::deleteAllLabels}
	$molUP::topGui.frame0.topSection.topMenu.tools.menu add command -label "Mouse mode: Rotate" -command {mouse mode rotate}
	$molUP::topGui.frame0.topSection.topMenu.tools.menu add command -label "Mouse mode: Translate" -command {mouse mode translate}
	$molUP::topGui.frame0.topSection.topMenu.tools.menu add command -label "Mouse mode: Scale" -command {mouse mode scale}

	place [ttk::menubutton $molUP::topGui.frame0.topSection.topMenu.structure -text "Structure" -menu $molUP::topGui.frame0.topSection.topMenu.structure.menu \
			-style molUP.menuBar.TMenubutton \
			] -in $molUP::topGui.frame0.topSection.topMenu -x 120 -y 5 -height 25 -width 80
	menu $molUP::topGui.frame0.topSection.topMenu.structure.menu -tearoff 0
	$molUP::topGui.frame0.topSection.topMenu.structure.menu add command -label "Modify bond" -command {molUP::bondModifInitialProc}
	$molUP::topGui.frame0.topSection.topMenu.structure.menu add command -label "Modify angle" -command {molUP::angleModifInitialProc}
	$molUP::topGui.frame0.topSection.topMenu.structure.menu add command -label "Modify dihedral" -command {molUP::dihedModifInitialProc}
	$molUP::topGui.frame0.topSection.topMenu.structure.menu add command -label "Add atoms" -command {molUP::guiAddAtoms}
	$molUP::topGui.frame0.topSection.topMenu.structure.menu add command -label "Delete atoms" -command {molUP::guiDeleteAtoms}


	place [ttk::menubutton $molUP::topGui.frame0.topSection.topMenu.publication -text "Publication" -menu $molUP::topGui.frame0.topSection.topMenu.publication.menu \
			-style molUP.menuBar.TMenubutton \
			] -in $molUP::topGui.frame0.topSection.topMenu -x 210 -y 5 -height 25 -width 95
	menu $molUP::topGui.frame0.topSection.topMenu.publication.menu -tearoff 0	
	#$molUP::topGui.frame0.topSection.topMenu.publication.menu add command -label "Methodology" -command {molUP::methodology}
	$molUP::topGui.frame0.topSection.topMenu.publication.menu add command -label "References to cite" -command {molUP::citations}


	place [ttk::menubutton $molUP::topGui.frame0.topSection.topMenu.about -text "About" -menu $molUP::topGui.frame0.topSection.topMenu.about.menu \
			-style molUP.menuBar.TMenubutton \
			] -in $molUP::topGui.frame0.topSection.topMenu -x 325 -y 5 -height 25 -width 65
	menu $molUP::topGui.frame0.topSection.topMenu.about.menu -tearoff 0
	$molUP::topGui.frame0.topSection.topMenu.about.menu add command -label "Credits" -command {molUP::guiCredits}
	$molUP::topGui.frame0.topSection.topMenu.about.menu add command -label "Changelog" -command {molUP::guiChangelog}
	#$molUP::topGui.frame0.topSection.topMenu.about.menu add command -label "Check for updates" -command {molUP::guiError "No updates available." "Updates"}


	## Molecule Selection #############################################
	pack [canvas $molUP::topGui.frame0.molSelection -bg #ededed -width 400 -height 50 -highlightthickness 0] -in $molUP::topGui.frame0

	place [ttk::label $molUP::topGui.frame0.molSelection.label \
			-style molUP.gray.TLabel \
			-text {Molecule } ] -in $molUP::topGui.frame0.molSelection -x 5 -y 2

	variable topMolecule "No molecule"
	variable molinfoList {}
	global ::vmd_molecule
	trace add variable ::vmd_initialize_structure write molUP::updateStructuresFromOtherSource
	place [ttk::combobox $molUP::topGui.frame0.molSelection.combo \
			-textvariable molUP::topMolecule \
			-style molUP.TCombobox \
			-values "$molUP::molinfoList" \
			-state readonly \
			] -in $molUP::topGui.frame0.molSelection -x 70 -y 0 -width 325
	bind $molUP::topGui.frame0.molSelection.combo <<ComboboxSelected>> {molUP::selectMolecule}

	place [ttk::label $molUP::topGui.frame0.molSelection.framelabel \
			-style molUP.gray.TLabel \
			-text {Frame } ] -in $molUP::topGui.frame0.molSelection -x 5 -y 24

	place [ttk::scale $molUP::topGui.frame0.molSelection.framescale \
			-from 0 \
			-to 0 \
			-value 0 \
			-length 325 \
			-command {molUP::frameSelector} \
			] -in $molUP::topGui.frame0.molSelection -x 70 -y 25 -width 325
	trace variable ::vmd_frame w molUP::frameChanged


	
	## Results section ################################################ 
	set molUP::majorHeight [expr $sHeight - 230]
	pack [canvas $molUP::topGui.frame0.major -bg #ededed -width 400 -height $molUP::majorHeight -highlightthickness 0] -in $molUP::topGui.frame0
	

	## Representantions ################################################
	pack [canvas $molUP::topGui.frame0.rep -bg #ededed -width 400 -height 90 -highlightthickness 0 -relief raised] -in $molUP::topGui.frame0
	set rep $molUP::topGui.frame0.rep

	place [ttk::label $rep.quickRepLabel \
			-text {Representations} \
			-style molUP.grayCenter.TLabel \
			] -in $rep -x 0 -y 0 -width 400

	place [ttk::checkbutton $rep.showHL \
			-text "High Layer" \
			-variable molUP::HLrep \
			-command {molUP::onOffRepresentation 1} \
			-style molUP.TCheckbutton \
			] -in $rep -x 5 -y 25 -width 123

	place [ttk::checkbutton $rep.showML \
			-text "Medium Layer" \
			-variable molUP::MLrep \
			-command {molUP::onOffRepresentation 2} \
			-style molUP.TCheckbutton \
			] -in $rep -x 138 -y 25 -width 123

	place [ttk::checkbutton $rep.showLL \
			-text "Low Layer" \
			-variable molUP::LLrep \
			-command {molUP::onOffRepresentation 3} \
			-style molUP.TCheckbutton \
			] -in $rep -x 271 -y 25 -width 123

	place [ttk::checkbutton $rep.unfreeze \
			-text "Unfreeze" \
			-variable molUP::unfreezeRep \
			-command {molUP::onOffRepresentation 7} \
			-style molUP.TCheckbutton \
			] -in $rep -x 5 -y 45 -width 123

	place [ttk::checkbutton $rep.freezeMinusOne \
			-text "Freeze" \
			-variable molUP::freezeRep \
			-command {molUP::onOffRepresentation 8} \
			-style molUP.TCheckbutton \
			] -in $rep -x 138 -y 45 -width 123

	place [ttk::checkbutton $rep.all \
			-text "All" \
			-variable molUP::allRep \
			-command {molUP::onOffRepresentation 12} \
			-style molUP.TCheckbutton \
			] -in $rep -x 271 -y 45 -width 123

	place [ttk::checkbutton $rep.protein \
			-text "Protein" \
			-variable molUP::proteinRep \
			-command {molUP::onOffRepresentation 4} \
			-style molUP.TCheckbutton \
			] -in $rep -x 5 -y 65 -width 123

	place [ttk::checkbutton $rep.nonProtein \
			-text "Non-Protein" \
			-variable molUP::nonproteinRep \
			-command {molUP::onOffRepresentation 5} \
			-style molUP.TCheckbutton \
			] -in $rep -x 138 -y 65 -width 123

	place [ttk::checkbutton $rep.water \
			-text "Water" \
			-variable molUP::waterRep \
			-command {molUP::onOffRepresentation 6} \
			-style molUP.TCheckbutton \
			] -in $rep -x 271 -y 65 -width 123


	#### Toolbar Menu Bootom ################################################
	pack [canvas $molUP::topGui.frame0.bottomToolbar -bg #b3dbff -width 400 -height 40 -highlightthickness 0 -relief raised] -in $molUP::topGui.frame0
	place [ttk::frame $molUP::topGui.frame0.bottomToolbar.frame -style molUP.menuBar.TFrame] -in $molUP::topGui.frame0.bottomToolbar -x 0 -y 0 -width 400 -height 40

	set tbar $molUP::topGui.frame0.bottomToolbar.frame
	place [ttk::button $tbar.resetView \
			-text "Reset View" \
			-command {display resetview} \
			-style molUP.reset.TButton \
			] -in $tbar -x 6 -y 5 -width 30
	balloon $tbar.resetView -text "Reset View"

	place [ttk::button $tbar.centerAtom \
			-text "Center atom" \
			-command {mouse mode center} \
			-style molUP.center.TButton \
			] -in $tbar -x 37 -y 5 -width 30
	balloon $tbar.centerAtom -text "Center atom"

	place [ttk::button $tbar.deleteAllLabels \
			-text "Delete all labels" \
			-command {molUP::deleteAllLabels} \
			-style molUP.deleteAllLabels.TButton \
			] -in $tbar -x 68 -y 5 -width 30
	balloon $tbar.deleteAllLabels -text "Delete all labels"

	place [ttk::button $tbar.mouseModeRotate \
			-text "Mouse mode: Rotate" \
			-command {mouse mode rotate} \
			-style molUP.mouseModeRotate.TButton \
			] -in $tbar -x 104 -y 5 -width 30
	balloon $tbar.mouseModeRotate -text "Mouse mode: Rotate"

	place [ttk::button $tbar.mouseModeTranslate \
			-text "Mouse mode: Translate" \
			-command {mouse mode translate} \
			-style molUP.mouseModeTranslate.TButton \
			] -in $tbar -x 135 -y 5 -width 30
	balloon $tbar.mouseModeTranslate -text "Mouse mode: Translate"

	place [ttk::button $tbar.mouseModeScale \
			-text "Mouse mode: Scale" \
			-command {mouse mode scale} \
			-style molUP.mouseModeScale.TButton \
			] -in $tbar -x 166 -y 5 -width 30
	balloon $tbar.mouseModeScale -text "Mouse mode: Scale"

	place [ttk::button $tbar.addRemoveBonds \
			-text "Add/Remove Bonds" \
			-command {mouse mode addbond} \
			-style molUP.addRemoveBonds.TButton \
			] -in $tbar -x 197 -y 5 -width 30
	balloon $tbar.addRemoveBonds -text "Mouse mode: Add/Remove Bonds"

	place [ttk::button $tbar.bondEdit \
			-text "Modify bond" \
			-command {molUP::bondModifInitialProc} \
			-style molUP.bondEdit.TButton \
			] -in $tbar -x 233 -y 5 -width 30
	balloon $tbar.bondEdit -text "Modify bond"

	place [ttk::button $tbar.angleEdit \
			-text "Modify angle" \
			-command {molUP::angleModifInitialProc} \
			-style molUP.angleEdit.TButton \
			] -in $tbar -x 264 -y 5 -width 30
	balloon $tbar.angleEdit -text "Modify angle"

	place [ttk::button $tbar.dihedralEdit \
			-text "Modify dihedral" \
			-command {molUP::dihedModifInitialProc} \
			-style molUP.dihedralEdit.TButton \
			] -in $tbar -x 295 -y 5 -width 30
	balloon $tbar.dihedralEdit -text "Modify dihedral"

	place [ttk::button $tbar.addAtoms \
			-text "Add Atoms" \
			-command {molUP::guiAddAtoms} \
			-style molUP.addAtoms.TButton \
			] -in $tbar -x 331 -y 5 -width 30
	balloon $tbar.addAtoms -text "Add atoms and/or molecular fragments"

	place [ttk::button $tbar.removeAtoms \
			-text "Remove Atoms" \
			-command {molUP::guiDeleteAtoms} \
			-style molUP.removeAtoms.TButton \
			] -in $tbar -x 362 -y 5 -width 30
	balloon $tbar.removeAtoms -text "Remove atoms"





	#### Place results of current molecules ################################################	
	set molAlreadyLoaded [molinfo list]
	if {$molAlreadyLoaded == ""} {
		place [ttk::label $molUP::topGui.frame0.major.labelEmpty \
			-text "No molecule loaded." \
			-style molUP.gray.TLabel \
			] -in $molUP::topGui.frame0.major -x 125 -y [expr $molUP::majorHeight / 2]
	} else {
		# Launch a wait window
		molUP::guiError "Pleasy wait a moment...\nThis window closes automatically when all the tasks have finished." "Wait a moment..."
		
		foreach mol $molAlreadyLoaded {
			molUP::resultSection $mol $molUP::topGui.frame0.major $molUP::majorHeight
			set molUP::allRep "1"
			molUP::getMolinfoList
			molUP::collectMolInfo
			molUP::addSelectionRep
			molUP::activateMolecule $mol
		}
		
		# Pack TOP molecule
		set molID [lindex $molUP::topMolecule 0]
		pack $molUP::topGui.frame0.major.mol$molID
		
		# Destroy waiting window
		destroy $::molUP::error
	}

}

proc molUP::getMolinfoList {} {
	set molUP::molinfoList {}
	
	set a [molinfo top]

	if {$a == -1} {
		set molUP::topMolecule "No molecule"
	} else {
		set molUP::topMolecule "[molinfo top] : [molinfo top get name]"

		set list [molinfo list]
		foreach mol $list {
			set molDetails "$mol : [molinfo $mol get name]"
			lappend molUP::molinfoList $molDetails
		}
	}

	$molUP::topGui.frame0.molSelection.combo configure -values $molUP::molinfoList
}

proc molUP::selectMolecule {} {
	set mol [lindex $molUP::topMolecule 0]
	mol top $mol


	set molList [molinfo list]
	foreach molecule $molList {
		pack forget $molUP::topGui.frame0.major.mol$molecule
	}

	pack $molUP::topGui.frame0.major.mol$mol

	mol off all
	mol on $mol

	## Update representantion on/off status
	set molUP::HLrep [mol showrep $mol 1]
	set molUP::MLrep [mol showrep $mol 2]
	set molUP::LLrep [mol showrep $mol 3]
	set molUP::unfreezeRep [mol showrep $mol 7]
	set molUP::freezeRep [mol showrep $mol 8]
	set molUP::allRep [mol showrep $mol 12]
	set molUP::proteinRep [mol showrep $mol 4]
	set molUP::nonproteinRep [mol showrep $mol 5]
	set molUP::waterRep [mol showrep $mol 6]

	# Update charges
	molUP::getChargesSum none

	# Update frames selector
	$molUP::topGui.frame0.molSelection.framescale configure -to [expr [molinfo top get numframes] -1]
	$molUP::topGui.frame0.molSelection.framescale configure -value [molinfo top get frame]

}


proc molUP::activateMolecule {molID} {
	## Set molecule to top
	mol top [lindex $molUP::topMolecule 0]

	## Delete previous info
	$molUP::tableCharges delete 0 end
	$molUP::tableLayer delete 0 end
	$molUP::tableFreeze delete 0 end

	## Add info to tables
	set sel [atomselect [lindex $molUP::topMolecule 0] all]
	set index [$sel get index]
	set type [$sel get type]
	set name [$sel get name]
	set resname [$sel get resname]
	set resid [$sel get resid]


	# Index
	$molUP::tableCharges insertlist end $index
	$molUP::tableLayer insertlist end $index
	$molUP::tableFreeze insertlist end $index

	# Atom Type
	$molUP::tableCharges columnconfigure 1 -text $type
	$molUP::tableLayer columnconfigure 1 -text $name
	$molUP::tableFreeze columnconfigure 1 -text $name

	# Resname
	$molUP::tableCharges columnconfigure 2 -text $resname
	$molUP::tableLayer columnconfigure 2 -text $resname
	$molUP::tableFreeze columnconfigure 2 -text $resname
	
	# Resid
	$molUP::tableCharges columnconfigure 3 -text $resid
	$molUP::tableLayer columnconfigure 3 -text $resid
	$molUP::tableFreeze columnconfigure 3 -text $resid

	# Specific
	$molUP::tableCharges columnconfigure 4 -text [$sel get charge] -formatcommand {format %8.6f}
	$molUP::tableFreeze columnconfigure 4 -text [$sel get user] -formatcommand {format %1.0f}
	$molUP::tableLayer columnconfigure 4 -text [$sel get altloc]
	
	#### Update input information
	set pos [lsearch $molUP::moleculeInfo "molID[molinfo top]"]
	set molUP::actualTitle [lindex $molUP::moleculeInfo [expr $pos +1]]
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.keywordsText delete 1.0 end
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.keywordsText insert end [lindex $molUP::moleculeInfo [expr $pos +2]]
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect delete 1.0 end
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect insert end [lindex $molUP::moleculeInfo [expr $pos +4]]
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.param delete 1.0 end
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.param insert end [lindex $molUP::moleculeInfo [expr $pos +5]]

}


proc molUP::activateMoleculeNEW {molID} {
	## Set molecule to top
	mol top [lindex $molUP::topMolecule 0]

	## Delete previous info
	$molUP::tableCharges delete 0 end
	$molUP::tableLayer delete 0 end
	$molUP::tableFreeze delete 0 end

	$molUP::tableCharges insertlist end $molUP::structureReadyToLoadCharges
	$molUP::tableLayer insertlist end $molUP::structureReadyToLoadLayer
	$molUP::tableFreeze insertlist end $molUP::structureReadyToLoadFreeze

	#### Update input information
	set pos [lsearch $molUP::moleculeInfo "molID[molinfo top]"]
	set molUP::actualTitle [lindex $molUP::moleculeInfo [expr $pos +1]]
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.keywordsText delete 1.0 end
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.keywordsText insert end [lindex $molUP::moleculeInfo [expr $pos +2]]
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect delete 1.0 end
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect insert end [lindex $molUP::moleculeInfo [expr $pos +4]]
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.param delete 1.0 end
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.param insert end [lindex $molUP::moleculeInfo [expr $pos +5]]

}


proc molUP::updateStructures {} {

	# Launch a wait window
	#molUP::guiError "Pleasy wait a moment...\nThis window closes automatically when all the tasks have finished." "Wait a moment..."
	
	set previousMol [molinfo list]
	foreach a $previousMol {
		pack forget $molUP::topGui.frame0.major.mol$a
	}

	set mol [lindex [molinfo list] end]
	molUP::resultSection $mol $molUP::topGui.frame0.major $molUP::majorHeight

	# Pack TOP molecule
	pack $molUP::topGui.frame0.major.mol$mol
	

	set molUP::allRep "1"
	molUP::getMolinfoList
	molUP::collectMolInfo
	molUP::activateMoleculeNEW $mol
	molUP::selectMolecule
	molUP::addSelectionRep

	molUP::guiChargeMulti $molUP::chargeMultiFrame

	molUP::checkTags .molUP.frame0.major.mol$mol.tabs.tabInput.keywordsText
		
	# Destroy waiting window
	#destroy $::molUP::error
}

proc molUP::updateStructuresFromOtherSource {args} {

	set molID [lindex $args 1]
	set value [lsearch -index 0 -all $molUP::molinfoList $molID]

	if {$value == ""} {
		# Launch a wait window
		#molUP::guiError "Pleasy wait a moment...\nThis window closes automatically when all the tasks have finished." "Wait a moment..."
		
		set previousMol [molinfo list]
		foreach a $previousMol {
			pack forget $molUP::topGui.frame0.major.mol$a
		}

		set mol [lindex [molinfo list] end]
		molUP::resultSection $mol $molUP::topGui.frame0.major $molUP::majorHeight

		# Pack TOP molecule
		pack $molUP::topGui.frame0.major.mol$mol
		

		set molUP::allRep "1"
		molUP::getMolinfoList
		molUP::collectMolInfo
		molUP::activateMolecule $mol
		molUP::selectMolecule
		molUP::addSelectionRep

		molUP::guiChargeMulti $molUP::chargeMultiFrame

		molUP::checkTags .molUP.frame0.major.mol$mol.tabs.tabInput.keywordsText

		set molUP::allRep 1
			
		# Destroy waiting window
		#destroy $::molUP::error

	} else {
		destroy $molUP::topGui.frame0.major.mol$molID
		molUP::getMolinfoList
		set molUP::topMolecule "[molinfo top] : [molinfo [lindex $molUP::topMolecule 0] get name]"
	}

}


proc molUP::collectMolInfo {} {
	### Structure molID, title, keywords, charges/Milti, connectivity, parameters

	if {$molUP::connectivity == ""} {
		set molUP::connectivity [molUP::connectivityFromVMD all]
	}

	lappend molUP::moleculeInfo "molID[molinfo top]" $molUP::title $molUP::keywordsCalc $molUP::chargesMultip $molUP::connectivity $molUP::parameters
	
	### Clear variables
	set molUP::title "molUP VMD is a very good plugin :)"
	set molUP::keywordsCalc "%mem=7000MB\n%NProc=4\n%chk=name.chk\n# "
	#set molUP::chargesMultip "" This cannot be active in order to molUP::applyChargeMultiplicityFromFile proc works
	set molUP::connectivity ""
	set molUP::parameters ""

}


proc molUP::textSearch {w string tag} {
   $w tag remove search 0.0 end
   if {$string == ""} {
	return
   }
   set cur 1.0
   while 1 {
	set cur [$w search -nocase -count length $string $cur end]
	if {$cur == ""} {
	    break
	}
	$w tag add $tag $cur "$cur + $length char"
	set cur [$w index "$cur + $length char"]
   }
}

proc molUP::readKeywordsTags {} {
	catch {exec $molUP::grep "^\$color=" "$::molUPpath/user/references.txt" | $molUP::cut -f2 -d=} colorTagList
	variable keywordsTagColor [lsort -unique $colorTagList]

	foreach color $molUP::keywordsTagColor {
		variable keywordsTagColor[subst $color] {} 
		
		catch {exec $molUP::grep -n "$color" "$::molUPpath/user/references.txt" | $molUP::cut -f1 -d:} keywordsLineNumber

		foreach lineNumber $keywordsLineNumber {
			catch {exec $molUP::sed "[expr $lineNumber + 1],[expr $lineNumber + 1]!d" "$::molUPpath/user/references.txt" | $molUP::cut -f2 -d%} keyword
			lappend keywordsTagColor[subst $color] $keyword
		}
	}

}

proc molUP::checkTags {pathName} {

	foreach color $molUP::keywordsTagColor {
		set list [subst $[subst molUP::keywordsTagColor$color]]
		foreach word $list {
			molUP::textSearch $pathName $word "[subst $color]"
		}
		$pathName tag configure "[subst $color]" -foreground "$color"
	}

}



proc molUP::rebond {} {
	mol bondsrecalc [lindex $molUP::topMolecule 0]
	mol reanalyze [lindex $molUP::topMolecule 0]

	set molID [lindex $molUP::topMolecule 0]

	set connectivity [molUP::connectivityFromVMD all]

	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect delete 1.0 end
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect insert end $connectivity
}

proc molUP::getConnectivityFromVMD {} {
	set molID [lindex $molUP::topMolecule 0]

	set connectivity [molUP::connectivityFromVMD all]

	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect delete 1.0 end
	$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect insert end $connectivity
}

proc molUP::applyNewConnectivity {} {
	set molID [lindex $molUP::topMolecule 0]
	set molUP::connectivity [.molUP.frame0.major.mol$molID.tabs.tabInput.connect get 1.0 end]

	set connectList [molUP::convertGaussianInputConnectToVMD $molUP::connectivity]
	topo clearbonds
	topo setbondlist $connectList

}



proc molUP::resultSection {molID frame majorHeight} {
	pack [canvas $frame.mol$molID -bg #ededed -width 400 -height $molUP::majorHeight -highlightthickness 0] -in $frame

	set major $frame.mol$molID

	place [ttk::notebook $major.tabs \
		-style molUP.major.TNotebook
		] -in $major -x 0 -y 0 -width 400 -height $molUP::majorHeight
	$major.tabs add [frame $major.tabs.tabResults -background #b3dbff -relief flat] -text "Model"
	$major.tabs add [frame $major.tabs.tabInput -background #b3dbff -relief flat] -text "Input"
	$major.tabs add [frame $major.tabs.tabOutput -background #b3dbff -relief flat] -text "Output"
	
	
	#####################################################
	#####################################################
	################# TAB INPUT #########################
	#####################################################
	#####################################################
	#### Job Title
	set tInput $major.tabs.tabInput
	place [ttk::label $tInput.jobTitleLabel \
		-style molUP.cyan.TLabel \
		-text {Job Title} ] -in $tInput -x 5 -y 5
	
	place [text $tInput.jobTitleEntry \
		-yscrollcommand "$tInput.yscb0 set" \
		-bd 1 \
		-highlightcolor #017aff \
		-highlightthickness 1 \
		-wrap word \
		-font TkDefaultFont \
		] -in $tInput -x 5 -y 25 -width 375 -height 25
	$tInput.jobTitleEntry insert end $molUP::title

	place [ttk::scrollbar $tInput.yscb0 \
			-orient vertical \
			-command [list $tInput.keywordsText yview]\
			] -in $tInput -x 380 -y 25 -width 15 -height 25

	place [ttk::button $tInput.infoButton \
        -style molUP.infoButton.TButton \
        -text "Information" \
		-command {molUP::guiInfo "gaussianInputTitle.txt"} \
		] -in $tInput -x 375 -y 5 -width 20 -height 20


	#### keywords
	place [ttk::menubutton $tInput.keywordsLabel -text "Calculations" -menu $tInput.keywordsLabel.menu \
			-style molUP.menuBar.TMenubutton \
			] -in $tInput -x 5 -y 60 -height 25 -width 160  
	menu $tInput.keywordsLabel.menu -tearoff 0
	molUP::readCalculationTypes [subst $tInput.keywordsLabel.menu]

	place [ttk::button $tInput.infoButtonKeywords \
        -style molUP.infoButton.TButton \
        -text "Information" \
		-command {molUP::methodology} \
		] -in $tInput -x 375 -y 60 -width 20 -height 20
	
	#place [ttk::label $tInput.keywordsLabel \
	#	-style molUP.cyan.TLabel \
	#	-text {Calculation keywords} ] -in $tInput -x 5 -y 60

	place [text $tInput.keywordsText \
		-yscrollcommand "$tInput.yscb set" \
		-bd 1 \
		-highlightcolor #017aff \
		-highlightthickness 1 \
		-wrap word \
		-font TkDefaultFont \
		] -in $tInput -x 5 -y 80 -width 375 -height 80
	$tInput.keywordsText insert end $molUP::keywordsCalc
	
	bind $tInput.keywordsText <KeyPress> "molUP::checkTags $tInput.keywordsText"

	place [ttk::scrollbar $tInput.yscb \
			-orient vertical \
			-command [list $tInput.keywordsText yview]\
			] -in $tInput -x 380 -y 80 -width 15 -height 80

	set resultsHeight [expr $molUP::majorHeight - 30 - 30]
	set heightBox [expr ($resultsHeight - 365 - 25 - 10) / 2]

	#### Connectivity 
	place [ttk::menubutton $tInput.connectLabel -text "Connectivity" -menu $tInput.connectLabel.menu \
			-style molUP.menuBar.TMenubutton \
			] -in $tInput -x 5 -y 340 -height 25 -width 110  
	menu $tInput.connectLabel.menu -tearoff 0
	$tInput.connectLabel.menu add command -label "Load connectivity from Gaussian Input File" -command {molUP::loadConnectivityFromOtherInputFile}
	$tInput.connectLabel.menu add command -label "Get current connectivity from VMD" -command {molUP::getConnectivityFromVMD}
	$tInput.connectLabel.menu add command -label "Apply custom connectivity" -command {molUP::applyNewConnectivity}
	$tInput.connectLabel.menu add command -label "Rebond" -command {molUP::rebond}

	place [ttk::button $tInput.infoButtonConnect \
        -style molUP.infoButton.TButton \
        -text "Information" \
		-command {molUP::guiInfo "gaussianInputConnect.txt"} \
		] -in $tInput -x 375 -y 340 -width 20 -height 20

	place [text $tInput.connect \
		-yscrollcommand "$tInput.yscb1 set" \
		-bd 1 \
		-highlightcolor #017aff \
		-highlightthickness 1 \
		-font TkDefaultFont \
		] -in $tInput -x 5 -y 365 -width 375 -height $heightBox

	place [ttk::scrollbar $tInput.yscb1 \
			-orient vertical \
			-command [list $tInput.connect yview]\
			] -in $tInput -x 380 -y 365 -width 15 -height $heightBox

	#### Parameters 
	place [ttk::menubutton $tInput.paramLabel -text "Other information (Parameters, Modredundant...)" -menu $tInput.paramLabel.menu \
			-style molUP.menuBar.TMenubutton \
			] -in $tInput -x 5 -y [expr 365 + $heightBox + 10] -height 25 -width 340  
	menu $tInput.paramLabel.menu -tearoff 0
	$tInput.paramLabel.menu add command -label "Load parameters from a PRMTOP file" -command {molUP::loadPrmtopParameters}
	$tInput.paramLabel.menu add command -label "ModRedundant Editor" -command {molUP::guiModRed}

	place [ttk::button $tInput.infoButtonParam \
        -style molUP.infoButton.TButton \
        -text "Information" \
		-command {molUP::guiInfo "gaussianInputParam.txt"} \
		] -in $tInput -x 375 -y [expr 365 + $heightBox + 10] -width 20 -height 20

	place [text $tInput.param \
		-yscrollcommand "$tInput.yscb2 set" \
		-bd 1 \
		-highlightcolor #017aff \
		-highlightthickness 1 \
		-font TkDefaultFont \
		] -in $tInput -x 5 -y [expr 365 + $heightBox + 10 + 25] -width 375 -height $heightBox

	place [ttk::scrollbar $tInput.yscb2 \
			-orient vertical \
			-command [list $tInput.param yview]\
			] -in $tInput -x 380 -y [expr 365 + $heightBox + 10 + 25] -width 15 -height $heightBox



	#####################################################
	#####################################################
	################# TAB STRUCTURE #####################
	#####################################################
	#####################################################

	set tResults $major.tabs.tabResults
	place [ttk::notebook $tResults.tabs \
		-style molUP.results.TNotebook \
		] -in $tResults -x 0 -y 0 -width 400 -height [expr $resultsHeight + 30]

	# Tabs Names
	$tResults.tabs add [frame $tResults.tabs.tab2 -background #ccffcc -relief flat] -text "Layer"
	$tResults.tabs add [frame $tResults.tabs.tab3 -background #ccffcc -relief flat] -text "Freeze"
	$tResults.tabs add [frame $tResults.tabs.tab4 -background #ccffcc -relief flat] -text "Charges"

	# Choose active tab
	$tResults.tabs select $tResults.tabs.tab2

	
	# Charges Tab
	variable tableCharges $tResults.tabs.tab4.tableLayer
	place [tablelist::tablelist $tResults.tabs.tab4.tableLayer \
			-showeditcursor true \
			-columns {0 "Index" center 0 "Gaussian Atom Type" center 0 "Resname" center 0 "Resid" center 0 "Charges" center} \
			-stretch all \
			-background white \
			-yscrollcommand [list $tResults.tabs.tab4.yscb set] \
			-xscrollcommand [list $tResults.tabs.tab4.xscb set] \
			-selectmode extended \
			-height 14 \
			-state normal \
			-borderwidth 0 \
			-relief flat \
			] -in $tResults.tabs.tab4 -x 0 -y 0 -width 375 -height [expr $resultsHeight - 60]

	place [ttk::scrollbar $tResults.tabs.tab4.yscb \
			-orient vertical \
			-command [list $tResults.tabs.tab4.tableLayer yview]\
			] -in $tResults.tabs.tab4 -x 375 -y 0 -width 20 -height [expr $resultsHeight - 60]

	place [ttk::scrollbar $tResults.tabs.tab4.xscb \
			-orient horizontal \
			-command [list $tResults.tabs.tab4.tableLayer xview]\
			] -in $tResults.tabs.tab4 -x 0 -y [expr $resultsHeight - 60] -height 20 -width 375

	place [ttk::button $tResults.tabs.tab4.updateChargesfromFile \
			-text "Update charges from file" \
			-command {molUP::updateChargesFromFile} \
			-style molUP.blue.TButton \
			] -in $tResults.tabs.tab4 -x 8 -y [expr $resultsHeight - 40 + 8] -width 182

	place [ttk::button $tResults.tabs.tab4.clearSelection \
			-text "Clear Selection" \
			-command {molUP::clearSelection charges} \
			-style molUP.blue.TButton \
			] -in $tResults.tabs.tab4 -x 201 -y [expr $resultsHeight - 40 + 8] -width 182

	$tResults.tabs.tab4.tableLayer configcolumns 0 -labelrelief raised 0 -labelbackground #b3dbff 0 -labelborderwidth 1
	$tResults.tabs.tab4.tableLayer configcolumns 1 -labelrelief raised 1 -labelbackground #b3dbff 1 -labelbd 1
	$tResults.tabs.tab4.tableLayer configcolumns 2 -labelrelief raised 2 -labelbackground #b3dbff 2 -labelbd 1
	$tResults.tabs.tab4.tableLayer configcolumns 3 -labelrelief raised 3 -labelbackground #b3dbff 3 -labelbd 1
	$tResults.tabs.tab4.tableLayer configcolumns 4 -editable true 4 -labelrelief raised 4 -labelbackground #b3dbff 4 -labelbd 1

	bind $tResults.tabs.tab4.tableLayer <<TablelistSelect>> {molUP::changeRepCurSelection charges}


	# Layer Tab
	variable tableLayer $tResults.tabs.tab2.tableLayer
	place [tablelist::tablelist $tResults.tabs.tab2.tableLayer \
			-showeditcursor true \
			-columns {0 "Index" center 0 "PDB Atom Type" center 0 "Resname" center 0 "Resid" center 0 "Layer" center} \
			-stretch all \
			-background white \
			-yscrollcommand [list $tResults.tabs.tab2.yscb set] \
			-xscrollcommand [list $tResults.tabs.tab2.xscb set] \
			-selectmode extended \
			-height 14 \
			-state normal \
			-borderwidth 0 \
			-relief flat \
			] -in $tResults.tabs.tab2 -x 0 -y 0 -width 375 -height [expr $resultsHeight - 120]

	place [ttk::scrollbar $tResults.tabs.tab2.yscb \
			-orient vertical \
			-command [list $tResults.tabs.tab2.tableLayer yview]\
			] -in $tResults.tabs.tab2 -x 375 -y 0 -width 20 -height [expr $resultsHeight - 120]

	place [ttk::scrollbar $tResults.tabs.tab2.xscb \
			-orient horizontal \
			-command [list $tResults.tabs.tab2.tableLayer xview]\
			] -in $tResults.tabs.tab2 -x 0 -y [expr $resultsHeight - 120] -height 20 -width 375

	place [ttk::label $tResults.tabs.tab2.selectionLabel \
			-text {Atom selection (Change ONIOM layer):} \
			-style molUP.lightGreen.TLabel \
			] -in $tResults.tabs.tab2 -x 5 -y [expr $resultsHeight - 100 + 5] -width 370

	place [ttk::entry $tResults.tabs.tab2.selection \
			-textvariable molUP::atomSelectionONIOM \
			-style molUP.TEntry \
			] -in $tResults.tabs.tab2 -x 5 -y [expr $resultsHeight - 100 + 35] -width 375
	#balloon $tResults.tabs.tab2.selection -text "You can also select atoms dragging in the list above"

	place [ttk::combobox $tResults.tabs.tab2.selectModificationValue \
			-textvariable molUP::selectionModificationValueOniom \
			-style molUP.green.TCombobox \
			-values "[list "H" "M" "L"]" \
			-state readonly \
			] -in $tResults.tabs.tab2 -x 5 -y [expr $resultsHeight - 100 + 65] -width 118
	#balloon $tResults.tabs.tab2.selectModificationValue -text "Choose a ONIOM layer - (H) High Layer, (M) Medium Layer and (L) Low Layer"

	place [ttk::button $tResults.tabs.tab2.pickAtoms \
			-text "Pick" \
			-command {molUP::pickAtomsLayer} \
			-style molUP.blue.TButton \
			] -in $tResults.tabs.tab2 -x 133 -y [expr $resultsHeight - 100 + 65] -width 54

	place [ttk::button $tResults.tabs.tab2.selectionApply \
			-text "Apply" \
			-command {molUP::applyToStructure oniom} \
			-style molUP.blue.TButton \
			] -in $tResults.tabs.tab2 -x 197 -y [expr $resultsHeight - 100 + 65] -width 54

	place [ttk::button $tResults.tabs.tab2.clearSelection \
			-text "Clear Selection" \
			-command {molUP::clearSelection oniom} \
			-style molUP.blue.TButton \
			] -in $tResults.tabs.tab2 -x 261 -y [expr $resultsHeight - 100 + 65] -width 118

	$tResults.tabs.tab2.tableLayer configcolumns 0 -labelrelief raised 0 -labelbackground #b3dbff 0 -labelborderwidth 1
	$tResults.tabs.tab2.tableLayer configcolumns 1 -labelrelief raised 1 -labelbackground #b3dbff 1 -labelbd 1
	$tResults.tabs.tab2.tableLayer configcolumns 2 -labelrelief raised 2 -labelbackground #b3dbff 2 -labelbd 1
	$tResults.tabs.tab2.tableLayer configcolumns 3 -labelrelief raised 3 -labelbackground #b3dbff 3 -labelbd 1
	$tResults.tabs.tab2.tableLayer configcolumns 4 -editable false 4 -labelrelief raised 4 -labelbackground #b3dbff 4 -labelbd 1

	bind $tResults.tabs.tab2.tableLayer <<TablelistSelect>> {molUP::changeRepCurSelection oniom}

	
	# Freeze Tab
	variable tableFreeze $tResults.tabs.tab3.tableLayer
	place [tablelist::tablelist $tResults.tabs.tab3.tableLayer\
			-showeditcursor true \
			-columns {0 "Index" center 0 "PDB Atom Type" center 0 "Resname" center 0 "Resid" center 0 "Freeze" center} \
			-stretch all \
			-background white \
			-yscrollcommand [list $tResults.tabs.tab3.yscb set] \
			-xscrollcommand [list $tResults.tabs.tab3.xscb set] \
			-selectmode extended \
			-height 14 \
			-state normal \
			-borderwidth 0 \
			-relief flat \
			] -in $tResults.tabs.tab3 -x 0 -y 0 -width 375 -height [expr $resultsHeight - 120]

	place [ttk::scrollbar $tResults.tabs.tab3.yscb \
			-orient vertical \
			-command [list $tResults.tabs.tab3.tableLayer yview]\
			] -in $tResults.tabs.tab3 -x 375 -y 0 -width 20 -height [expr $resultsHeight - 120]

	place [ttk::scrollbar $tResults.tabs.tab3.xscb \
			-orient horizontal \
			-command [list $tResults.tabs.tab3.tableLayer xview]\
			] -in $tResults.tabs.tab3 -x 0 -y [expr $resultsHeight - 120] -height 20 -width 375

	place [ttk::label $tResults.tabs.tab3.selectionLabel \
			-text {Atom selection (Change freezing state):} \
			-style molUP.lightGreen.TLabel \
			] -in $tResults.tabs.tab3 -x 5 -y [expr $resultsHeight - 100 + 5] -width 370

	place [ttk::entry $tResults.tabs.tab3.selection \
			-textvariable molUP::atomSelectionFreeze\
			-style molUP.TEntry \
			] -in $tResults.tabs.tab3 -x 5 -y [expr $resultsHeight - 100 + 35] -width 375
	#balloon $tResults.tabs.tab3.selection -text "You can also select atoms dragging in the list above"

	place [ttk::combobox $tResults.tabs.tab3.selectModificationValue \
			-textvariable molUP::selectionModificationValueFreeze \
			-style molUP.green.TCombobox \
			-values "[list "0" "-1" "-2" "-3"]" \
			] -in $tResults.tabs.tab3 -x 5 -y [expr $resultsHeight - 100 + 65] -width 118
	#balloon $tResults.tabs.tab3.selectModificationValue -text "Choose freeze option"

	place [ttk::button $tResults.tabs.tab3.pickAtoms \
			-text "Pick" \
			-command {molUP::pickAtomsFreeze} \
			-style molUP.TButton \
			] -in $tResults.tabs.tab3 -x 133 -y [expr $resultsHeight - 100 + 65] -width 54
	
	place [ttk::button $tResults.tabs.tab3.selectionApply \
			-text "Apply" \
			-command {molUP::applyToStructure freeze} \
			-style molUP.TButton \
			] -in $tResults.tabs.tab3 -x 197 -y [expr $resultsHeight - 100 + 65] -width 54

	place [ttk::button $tResults.tabs.tab3.clearSelection \
			-text "Clear Selection" \
			-command {molUP::clearSelection freeze} \
			-style molUP.TButton \
			] -in $tResults.tabs.tab3 -x 261 -y [expr $resultsHeight - 100 + 65] -width 118

	$tResults.tabs.tab3.tableLayer configcolumns 0 -labelrelief raised 0 -labelbackground #b3dbff 0 -labelborderwidth 1
	$tResults.tabs.tab3.tableLayer configcolumns 1 -labelrelief raised 1 -labelbackground #b3dbff 1 -labelbd 1
	$tResults.tabs.tab3.tableLayer configcolumns 2 -labelrelief raised 2 -labelbackground #b3dbff 2 -labelbd 1
	$tResults.tabs.tab3.tableLayer configcolumns 3 -labelrelief raised 3 -labelbackground #b3dbff 3 -labelbd 1
	$tResults.tabs.tab3.tableLayer configcolumns 4 -editable false 4 -labelrelief raised 4 -labelbackground #b3dbff 4 -labelbd 1

	bind $tResults.tabs.tab3.tableLayer <<TablelistSelect>> {molUP::changeRepCurSelection freeze}



	#### Charge and Multiplicity
	place [ttk::frame $tInput.chargeMulti \
		] -in $tInput -x 0 -y 170 -width 400 -height 160
	variable chargeMultiFrame $tInput.chargeMulti
	
	pack forget $frame.mol$molID


	#####################################################
	#####################################################
	################# TAB OUTPUT ########################
	#####################################################
	#####################################################

	set tOutput $major.tabs.tabOutput


	place [ttk::notebook $tOutput.tabs \
		-style molUP.results.TNotebook \
		] -in $tOutput -x 0 -y 0 -width 400 -height [expr $resultsHeight + 30]

	place [ttk::label $tOutput.tabs.warningText \
		-text {No results to show.} \
		-style molUP.cyan.TLabel \
		] -in $tOutput.tabs -x 140 -y [expr $resultsHeight / 2] -width 120 -height 30

}



proc molUP::loadConnectivityFromOtherInputFile {} {
	 set fileTypes {
                {{Gaussian Input File (.com)}       {.com}        }
        }
        set path [tk_getOpenFile -filetypes $fileTypes -defaultextension ".com" -title "Choose a Gaussian Input File..."]
		set molID [lindex $molUP::topMolecule 0]
        if {$path != ""} {
            set firstConnect [expr [molUP::getBlankLines $path 2] + 1]
			set lastConnect [expr [molUP::getBlankLines $path 3] - 1]
			catch {exec $molUP::sed -n "$firstConnect,$lastConnect p" $path} connectivity
			$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect delete 1.0 end
			$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.connect insert end $connectivity

			set firstParam [expr [molUP::getBlankLines $path 3] + 1]
			catch {exec $molUP::sed -n "$firstParam,\$ p" $path} param
			$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.param delete 1.0 end
			$molUP::topGui.frame0.major.mol$molID.tabs.tabInput.param insert end $param

			molUP::applyNewConnectivity

        } else {}
}



proc molUP::readCalculationTypes {pathName} {
	## Common options
	$pathName add command -label " ~ Save current input section ~ " -command "molUP::saveKeywordsInput"

	set listFiles [glob -directory "$::molUPpath/user/calculationSetup" *]

	foreach file $listFiles {
		catch {exec $molUP::sed -n "1,1p" $file} title
		$pathName add command -label "$title" -command "molUP::fillKeywordsSection [subst $file]"
	}

}

proc molUP::fillKeywordsSection {path} {
	.molUP.frame0.major.mol[lindex $molUP::topMolecule 0].tabs.tabInput.keywordsText delete 1.0 end
	catch {exec $molUP::sed -n "2,$ p" $path} keywords
	.molUP.frame0.major.mol[lindex $molUP::topMolecule 0].tabs.tabInput.keywordsText insert end $keywords

	# Update Tags
	molUP::checkTags .molUP.frame0.major.mol[lindex $molUP::topMolecule 0].tabs.tabInput.keywordsText

}

proc molUP::saveKeywordsInput {} {
	#### Check if the window exists
	if {[winfo exists $::molUP::saveKeywordsInput]} {wm deiconify $::molUP::saveKeywordsInput ;return $::molUP::saveKeywordsInput}
	toplevel $::molUP::saveKeywordsInput

	#### Title of the windows
	wm title $molUP::saveKeywordsInput "Save Keywords Section" ;# titulo da pagina

	#### Change the location of window
	# screen width and height
	set sWidth [expr [winfo vrootwidth  $::molUP::saveKeywordsInput] -0]
	set sHeight [expr [winfo vrootheight $::molUP::saveKeywordsInput] -50]

	#### Change the location of window
    wm geometry $::molUP::saveKeywordsInput 400x100+[expr $sWidth - 400]+100
	$::molUP::saveKeywordsInput configure -background {white}
	wm resizable $::molUP::saveKeywordsInput 0 0

	## Apply theme
	ttk::style theme use molUPTheme

    #### Information
    pack [ttk::frame $molUP::saveKeywordsInput.frame0]
	pack [canvas $molUP::saveKeywordsInput.frame0.frame -bg white -width 400 -height 100 -highlightthickness 0] -in $molUP::saveKeywordsInput.frame0

	place [ttk::label $molUP::saveKeywordsInput.frame0.frame.label1 \
		-text "Please, choose a name to save the current keywords section:" \
		-style molUP.white.TLabel \
	] -in $molUP::saveKeywordsInput.frame0.frame -x 10 -y 10 -width 380 -height 30

	place [ttk::entry $molUP::saveKeywordsInput.frame0.frame.entry \
			-textvariable nameKeywordsSectionSave \
			-style molUP.TEntry \
	] -in $molUP::saveKeywordsInput.frame0.frame -x 10 -y 35 -width 380

	place [ttk::button $molUP::saveKeywordsInput.frame0.frame.save \
			-text "Save" \
			-command {molUP::saveKeywordsInputLastStep $nameKeywordsSectionSave} \
			-style molUP.TButton \
	] -in $molUP::saveKeywordsInput.frame0.frame -x 150 -y 70 -width 100

}

proc molUP::saveKeywordsInputLastStep {name} {
	set text ""
	append text "$name\n"

	set keywords [.molUP.frame0.major.mol[lindex $molUP::topMolecule 0].tabs.tabInput.keywordsText get 1.0 end]
	append text "$keywords"

	set currentTime [clock seconds]
	set file [open "$::molUPpath/user/calculationSetup/$currentTime.txt" w]
	set path "$::molUPpath/user/calculationSetup/$currentTime.txt"

	puts $file "$text"
	close $file

	.molUP.frame0.major.mol[lindex $molUP::topMolecule 0].tabs.tabInput.keywordsLabel.menu add command -label "$name" -command "molUP::fillKeywordsSection [subst $path]"

	destroy $molUP::saveKeywordsInput

}

#### Pick Atoms ONIOM
proc molUP::pickAtomsLayer {} {
	molUP::clearSelection oniom
	set molUP::atomSelectionONIOM "index"
	variable pickAtomsLayerListPickedAtoms ""
	
	## Trace the variable to run a command each time a atom is picked
	trace variable ::vmd_pick_atom w molUP::pickAtomsLayerPicked
	
	## Activate atom pick
	mouse mode pick
}
proc molUP::pickAtomsLayerPicked {args} {
	if {[lsearch $molUP::pickAtomsLayerListPickedAtoms $::vmd_pick_atom] == -1} {
		lappend molUP::pickAtomsLayerListPickedAtoms $::vmd_pick_atom
	} else {
		set molUP::pickAtomsLayerListPickedAtoms [lsearch -all -inline -not $molUP::pickAtomsLayerListPickedAtoms $::vmd_pick_atom]
	}

	set molUP::atomSelectionONIOM "index $molUP::pickAtomsLayerListPickedAtoms"
	mol modselect 9 [lindex $molUP::topMolecule 0] index $molUP::pickAtomsLayerListPickedAtoms
}

#### Pick Atoms Freeze
proc molUP::pickAtomsFreeze {} {
	molUP::clearSelection freeze
	set molUP::atomSelectionFreeze "index"
	variable pickAtomsFreezeListPickedAtoms ""

	## Trace the variable to run a command each time a atom is picked
	trace variable ::vmd_pick_atom w molUP::pickAtomsFreezePicked
		
	## Activate atom pick
	mouse mode pick
}
proc molUP::pickAtomsFreezePicked {args} {
	if {[lsearch $molUP::pickAtomsFreezeListPickedAtoms $::vmd_pick_atom] == -1} {
		lappend molUP::pickAtomsFreezeListPickedAtoms $::vmd_pick_atom
	} else {
		set molUP::pickAtomsFreezeListPickedAtoms [lsearch -all -inline -not $molUP::pickAtomsFreezeListPickedAtoms $::vmd_pick_atom]
	}

	set molUP::atomSelectionFreeze "index $molUP::pickAtomsFreezeListPickedAtoms"
	mol modselect 9 [lindex $molUP::topMolecule 0] index $molUP::pickAtomsFreezeListPickedAtoms
}

proc molUP::frameSelector {args} {
	set frame [lindex [split $args "."] 0]

	animate goto $frame
}

proc molUP::frameChanged {args} {
	$molUP::topGui.frame0.molSelection.framescale configure -value [molinfo top get frame]
}