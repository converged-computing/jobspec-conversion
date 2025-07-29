#!/bin/bash
#SBATCH --output=/n/home15/dsussman/log/out-%a.txt
#SBATCH --error=/n/home15/dsussman/log/err-%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000
#SBATCH --time=10:00:00
#SBATCH --array=1-40

module load math/matlab-R2014b
matlab -nojvm -nodisplay -nodesktop -r \
	"job=$SLURM_ARRAY_TASK_ID;addpath(genpath('.'));testTwitter;quit"
