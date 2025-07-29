#!/bin/bash
#SBATCH --job-name=example_matlab
#SBATCH --account=railabs
#SBATCH --output=%x.%N.%J.%u.out
#SBATCH --error=matlab.%N.%J.%u.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --partition=defq

module load matlab/R2022b 
BASE_MFILE_NAME=helloworld_par
cd $SLURM_SUBMIT_DIR
matlab -nodisplay  -r "$BASE_MFILE_NAME"
