#!/bin/bash
#SBATCH --job-name=WIMPreproc
#SBATCH --account=cn25
#SBATCH --mail-user=thomas.andrillon@monash.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=16000
#SBATCH --time=12:00:00
#SBATCH --partition=m3g
#SBATCH --constraint=ntasks-per-node=1

module purge
module load matlab/r2017b
hostname
env | grep SLURM
matlab -nodisplay -r "wanderIM_preproc_eeg_parfor_v3; exit"
