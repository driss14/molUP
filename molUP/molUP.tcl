package provide molUP 1.0

#### INIT ############################################################
namespace eval molUP:: {
	namespace export molUP
	
		#### Load Packages				
		package require gui 									1.0
		package require guiBondModif							1.0
		package require guiAngleModif							1.0
		package require guiDihedModif							1.0
		package require guiOpenFile								1.0
		package require guiSaveFile								1.0
		package require guiError								1.0
		package require guiChargeMulti							1.0
		package require guiCalcSetup							1.0
		package require guiCredits								1.0
		
		package require inputFile 								1.0
		package require timeControl								1.0
		package require quit									1.0
		package require loadGaussianInputFile					2.0
		package require loadGaussianOutputFile					2.0
		package	require editStructure							1.0
		package require modify									1.0
		package require saveFiles								1.0
		package require readFreq								1.0
		package require energy									1.0
		package require plot									1.0


		package require Tk
		package require tablelist
		package require topotools
		package require balloon 								1.0

		# Theme
		package require gaussianTheme							1.0

		#### Program Variables

		## General
		variable version	    	"0.9 (beta)"

		#GUI
        variable topGui         	".molUP"
		variable bondModif         	".molUP.bondModif"
		variable angleModif        	".molUP.angleModif"
		variable dihedModif        	".molUP.dihedModif"
		variable openFile        	".molUP.openFile"
		variable saveFile        	".molUP.saveFile"
		variable error	        	".molUP.error"
		variable chargeMulti	    ".molUP.chargeMulti"
		variable calcSetup			".molUP.calcSetup"
		variable credits			".molUP.credits"

		global path
		variable path 				"/"
		variable fileName			""
		variable fileExtension		""
		variable title 				"Gaussian for VMD is a very good plugin :)"
		variable actualTitle		"Gaussian for VMD is a very good plugin :)"
		variable chargesMultip		""
		variable keywordsCalc		"%mem=7000MB\n%NProc=4\n%chk=name.chk\n\n# "
		variable structureGaussian	""
		variable loadingProgress	"0.0"
		variable atomicSymbolList 		
		variable gaussianAtomTypeList	
		variable pdbAtomTypeList	 	
		variable resnameList		 	
		variable residList		 		
		variable chargeList 			
		variable freezeList				
		variable xxList					
		variable yyList					
		variable zzList					
		variable atomDesigList			
		variable linkAtomList			
		variable linkAtomNumbList	
		variable linkAtomValueList
		variable numberAtoms
		variable numberStructures
		variable actualTime
		variable temporaryPDBFile
		variable temporaryXYZFile
		variable time0
		variable time1
		variable loadMode						""
		variable selectionModificationType		""
		variable selectionModificationValueOniom		""
		variable selectionModificationValueFreeze		""
		variable atomSelectionONIOM				"none"
		variable atomSelectionFreeze			"none"
		variable HLrep		"0"
		variable MLrep		"0"
		variable LLrep		"0"
		variable unfreezeRep	"0"
		variable showNegChargedResidues	"0"
		variable showPosChargedResidues	"0"
		variable freezeRep		"0"
		variable allRep			"1"
		variable proteinRep		"0"
		variable nonproteinRep	"0"
		variable waterRep		"0"
		variable pickedAtoms	{}
		variable atom1BondSel	"none"
		variable atom2BondSel	"none"
		variable atom1BondOpt	"Fixed Atom"
		variable atom2BondOpt	"Move Atom"
		variable atom1AngleSel	"none"
		variable atom2AngleSel	"none"
		variable atom3AngleSel	"none"
		variable atom1AngleOpt	"Fixed Atom"
		variable atom2AngleOpt	""
		variable atom3AngleOpt	"Move Atom"
		variable atom1DihedSel	"none"
		variable atom2DihedSel	"none"
		variable atom3DihedSel	"none"
		variable atom4DihedSel	"none"
		variable atom1DihedOpt	"Fixed Atom"
		variable atom2DihedOpt	""
		variable atom3DihedOpt	""
		variable atom4DihedOpt	"Move Atom"
		variable BondDistance			"0.01"
		variable initialBondDistance	"0.01"
		variable AngleValue				"0.00"
		variable initialAngleValue		"0.00"
		variable DihedValue				"0.00"
		variable initialDihedValue		"0.00"
		variable initialSelection {}
		variable initialSelectionX {}
		variable initialSelectionY {}
		variable initialSelectionZ {}
		variable pos1
		variable pos2
		variable pos3
		variable pos4
		variable normvec
		variable linkAtomsList		{}
		variable linkAtomsListIndex	{}
		variable saveOptions	"Gaussian Input File (.com)"
		variable connectivityInputFile ""
		variable connectivity ""
		variable parameters ""
		variable openNewFileMode "YES"
		variable tmpFolder ""
		variable structureReadyToLoad {}
		variable moleculeInfo {}


		variable chargeAll	0
		variable chargeHL	0
		variable chargeML	0
		variable chargeLL	0
		variable multiplicityValue		1
		variable multiplicityValue1		1
		variable multiplicityValue2		1
		
}


## Initiate ###
#molUP::loadImages
#molUP::buildGui
