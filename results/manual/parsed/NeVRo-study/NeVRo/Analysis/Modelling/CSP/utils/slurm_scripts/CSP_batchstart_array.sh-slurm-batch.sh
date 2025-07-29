#!/bin/bash
#SBATCH --job-name=MATLAB
#SBATCH --output=./job.out.%A_%a
#SBATCH --error=./job.err.%A_%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=72
#SBATCH --mem=100000
#SBATCH --time=23:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=./
#SBATCH --array=26-43

module load matlab
srun matlab -nodisplay -nosplash -nodesktop -noFigureWindows -r "run('CSP_slurm_array(${SLURM_ARRAY_TASK_ID}).m')"
