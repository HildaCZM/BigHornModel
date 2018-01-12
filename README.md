# BigHornModel
Scripts and Data Files for Replicating "Socio-ecological Resilience Modeling:  Drought Effects in the Bighorn Sheep Management in Baja California Sur, Mexico"
Instructions for running the Bighorn Resilience Analysis Model

1. Save scripts and data to your PC
2. The climate scenarios data and the experiment's output data can be stored  in a subfolder "Data"
3. A subfolder scripts should contain four scripts, which functions are as follows:
   Experimentation_Script_SES_Resiliense_vfinal.r: this script controls the bighorn model and can be used to replicate the results or to execute a new experiment, it creates the file: Output_vfinal.csv
   ModelSpecification_BighornManagement_vPaper.r: this script contains the matematical structure of the model
   SupportingVectors_BighornManagement.r: this script containts parameters' values, initial conditions and integreation method, the notes describe how each parameter in the model was estimated
   ClimateScenariosGenerator.r : this is the script used for creating the climate scenarios described in the paper, it creates the file: ClimateScenariosTable.csv
4. To run the model and experiment create and change the directories on the first line of the Experimentation_Script_SES_Resiliense_vfinal.r and then execute in R.
