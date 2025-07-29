#!/bin/bash
#SBATCH --output=/scratch/gpfs/jbreda/ephys/kilosort/logs/output_%j.out
#SBATCH --error=/scratch/gpfs/jbreda/ephys/kilosort/logs/error_%j.err
#SBATCH --mail-user=jbreda@princeton.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20000
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1,ntasks-per-socket=1

input_path="/scratch/gpfs/jbreda/ephys/kilosort/data_sdb_20190724_193007_fromSD_firstbundle_T5_W10000_forkilosort" 
repo_path="/scratch/gpfs/jbreda/ephys/kilosort/Brody_Lab_Ephys"
config_path="/scratch/gpfs/jbreda/ephys/kilosort/Brody_Lab_Ephys/utils/cluster_kilosort"
cd $config_path
module purge
module load matlab/R2018b
	matlab -singleCompThread -nosplash -nodisplay -nodesktop -r "main_kilosort_forcluster_wrapper('${input_path}','${config_path}','${repo_path}', 500);exit"
