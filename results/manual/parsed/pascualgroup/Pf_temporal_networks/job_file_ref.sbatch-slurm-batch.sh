#!/bin/bash
#FLUX: --job-name=XXX
#FLUX: --queue=broadwl
#FLUX: -t=36000
#FLUX: --urgency=16

module load python
module load gcc
PS='XXX' # the parameter space
scenario='XXX' # Can be: 'S', 'G' or 'N'
exp='XXX' # The experiment ID
run=$SLURM_ARRAY_TASK_ID # The run in the parameter space
base_folder='/scratch/midway2/pilosofs/malaria_interventions/' # Where all the source files are and where the experiment folders will be created
base_name='PS'$PS'_'$scenario'_E'$exp'_R'$run
ABM_file=varmodel2.zip
CHECKPOINT='create' # Can be: 'create', 'load', or 'none'
cd $base_folder # Go to base folder
rm -rf $base_name # Remove work folder if exists
mkdir $base_name
cp $base_name'.py' $base_name # Copy the parameter file
cp $ABM_file $base_name # Copy the ABM code
cd $base_name
unzip -qq $ABM_file # Unzip ABM code
echo Paramter file is: $base_name
./build.py -p $base_name'.py' -d $base_name
if [ "$CHECKPOINT" = "create" ]; then
	cd $base_name
	./bin/varmodel2
	cp *.sqlite $base_folder'/sqlite' 	# Copy sqlite files to the sqlite folder (include checkpoint files)
	# Arrange files
	# Or just delete the whole folder
	rm -rf $base_folder$base_name
fi
if [ "$CHECKPOINT" = "load" ]; then
	cp $base_folder'sqlite/PS'$PS'_'$scenario'_E000_R'$run'_CP.sqlite' $base_folder$base_name'/'$base_name # The control experiments are with E00
	cd $base_name
	# Run the ABM
	./bin/varmodel2
	# Arrange files
	cp *.sqlite $base_folder'/sqlite'
	# Arrange files
	rm -rf $base_name
	# Or just delete the whole folder
	rm -rf $base_folder$base_name
fi
