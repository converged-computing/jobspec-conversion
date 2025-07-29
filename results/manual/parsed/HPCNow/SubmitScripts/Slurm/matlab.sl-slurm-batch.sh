#!/bin/bash
#SBATCH --job-name=Serial_Job
#SBATCH --account=hpcnow
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=4G
#SBATCH --time=00:10:00

module load MATLAB/R2012b
srun matlab -nodesktop -nosplash -r myLu
