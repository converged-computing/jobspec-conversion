#!/bin/bash
#FLUX: --job-name=blank-train-6382
#FLUX: -t=21600
#FLUX: --urgency=16

input_base_path="/scratch/gpfs/jbreda/ephys/kilosort/W122/preprocessed_W122_19523713" 
repo_path="/scratch/gpfs/jbreda/ephys/kilosort/Brody_Lab_Ephys"
config_path="/scratch/gpfs/jbreda/ephys/kilosort/Brody_Lab_Ephys/utils/cluster_kilosort"
echo "Array Index: $SLURM_ARRAY_TASK_ID"
cd $input_base_path
bin_folders=`ls -d */`
bin_folders_arr=($bin_folders)
arr=$SLURM_ARRAY_TASK_ID
cd $config_path
module purge
module load matlab/R2018b
	matlab -singleCompThread -nosplash -nodisplay -nodesktop -r "main_kilosort_forcluster_parallel_wrapper('${bin_folders_arr[${arr}]}','${input_base_path}','${config_path}','${repo_path}', 500);exit"
