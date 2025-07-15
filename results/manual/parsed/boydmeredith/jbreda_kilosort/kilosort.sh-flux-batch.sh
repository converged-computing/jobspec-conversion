#!/bin/bash
#FLUX: --job-name=psycho-hobbit-0461
#FLUX: --priority=16

input_path="/scratch/gpfs/jbreda/ephys/kilosort/data_sdb_20190724_193007_fromSD_firstbundle_T5_W10000_forkilosort" 
repo_path="/scratch/gpfs/jbreda/ephys/kilosort/Brody_Lab_Ephys"
config_path="/scratch/gpfs/jbreda/ephys/kilosort/Brody_Lab_Ephys/utils/cluster_kilosort"
cd $config_path
module purge
module load matlab/R2018b
	matlab -singleCompThread -nosplash -nodisplay -nodesktop -r "main_kilosort_forcluster_wrapper('${input_path}','${config_path}','${repo_path}', 500);exit"
