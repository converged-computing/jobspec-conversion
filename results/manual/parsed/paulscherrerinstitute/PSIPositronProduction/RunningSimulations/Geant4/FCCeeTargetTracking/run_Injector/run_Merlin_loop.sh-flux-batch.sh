#!/bin/bash
#FLUX: --job-name=confused-lemur-4228
#FLUX: -c=32
#FLUX: --queue=hourly,daily,general
#FLUX: -t=900
#FLUX: --urgency=16

ncore=$SLURM_CPUS_PER_TASK
config_file=config_loop.mac
output_filename=FCCeeTargetTracking  
tree_option="all"
seed=1
for driveBeamE in $(seq 20 10 50)
do
    for targetThickness in $(seq 1 1 15)
    do
	echo "Simulating with E_DRIVE_BEAM = $driveBeamE MeV, TARGET_THICKNESS = $targetThickness mm..."
	tmpDir=./E${driveBeamE}MeV_D${targetThickness}mm
	mkdir $tmpDir
	cp ./${config_file} ${tmpDir}/
	cd $tmpDir
	sed -i "s/E_DRIVE_BEAM/${driveBeamE}/" $config_file
	sed -i "s/TARGET_THICKNESS/${targetThickness}/" $config_file
	module purge
	module load gcc/7.3.0
	module load geant4/10.5_multithreaded
	module load root/6.12.06
	source geant4.sh
	../../Injector_build/injector $config_file $ncore $tree_option $seed |& tee logfile
	## Merge outputs
	echo "Merging root files ..."
	if [[ $ncore -gt 1 ]];then
	    hadd -f ${output_filename}.root ${output_filename}_t*.root
	    rm -f ${output_filename}_t*.root
	elif [[ $ncore -eq 1 ]];then
	    mv ${output_filename}_t0.root ${output_filename}.root
	fi
	root -l -b -q ../show_N_positrons.C
	## Convert to Pcubed standard format
	module purge
	module load anaconda/2019.07
	conda activate hep_root
	source ../../../../RepoSetup/Set_Pythonpath.sh
	python ../convert_fcceett_to_standard_df.py ${output_filename}.root
	cd ..
    done
done
echo "Job finished!"
