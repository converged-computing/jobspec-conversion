#!/bin/bash
#SBATCH --job-name=GN_coeff
#SBATCH --output=GN_coeff_%A_%a.out
#SBATCH --error=GN_coeff_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4000
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal
#SBATCH --qos=long
#SBATCH --array=1-6

echo "SLURM_ARRAY_TASK_ID is " $SLURM_ARRAY_TASK_ID
module load matlab
srun matlab -nodesktop -singleCompThread -r "GN_model_coeff_slurm 50 $SLURM_ARRAY_TASK_ID"
