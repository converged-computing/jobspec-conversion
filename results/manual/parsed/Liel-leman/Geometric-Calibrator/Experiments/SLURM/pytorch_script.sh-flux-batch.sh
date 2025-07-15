#!/bin/bash
#FLUX: --job-name=${i}CNN_${dataset}
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: -t=604800
#FLUX: --urgency=16

norm="L2"
START=0
END=99
model="cnn"
declare -a arr_data=("SignLanguage")
	for dataset in "${arr_data[@]}"
		do
		if [ $dataset == "SignLanguage" ]
		then
			RAM="10"
		elif [ $dataset == "MNIST" ] || [ $dataset == "Fashion" ]
		then
			RAM="10"
		elif [ $dataset == "CIFAR_RGB" ]
		then
			RAM="20"
		elif [ $dataset == "GTSRB_RGB" ]
		then
			RAM="30"
		fi
	#for i in ${myArray[@]}
	for i in $(eval echo "{$START..$END}")
		do
			File="sbatch_${dataset}_${model}_${i}.example"
			if [ ! -e "$File" ]; then              #Check if file exists
				echo "Creating file $File"
				touch $File                          #Create file if it doesn't exist
			fi 
			cat <<- EOF > $File
			#!/bin/bash
			################################################################################################
			### sbatch configuration parameters must start with #SBATCH and must precede any other commands.
			### To ignore, just add another # - like so: ##SBATCH
			################################################################################################
			# Note: the following 4 lines are commented out
			### Print some data to output file ###
			echo `date`
			echo -e "\nSLURM_JOBID:\t\t" $SLURM_JOBID
			echo -e "SLURM_JOB_NODELIST:\t" $SLURM_JOB_NODELIST "\n\n"
			### Start your code below ####
			module load anaconda				### load anaconda module (must be present when working with conda environments)
			source activate ML				### activate a conda environment, replace my_env with your conda environment
			python pytorchShuffle.py ${dataset} ${i} ${norm}	### execute python script – replace with your own command 
			EOF
			sbatch $File 
		done
	done
