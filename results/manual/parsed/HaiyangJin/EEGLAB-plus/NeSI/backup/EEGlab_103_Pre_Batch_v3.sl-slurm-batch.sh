#!/bin/bash
#SBATCH --job-name=103
#SBATCH --account=uoa00424
#SBATCH --mail-user=hjin317@aucklanduni.ac.nz
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4096
#SBATCH --time=06:00:00
#SBATCH --array=34

module load MATLAB/2017b
srun matlab -nodesktop -nosplash -r EEGlab_101_Pre_Batch_v3 $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_JOB_ID
