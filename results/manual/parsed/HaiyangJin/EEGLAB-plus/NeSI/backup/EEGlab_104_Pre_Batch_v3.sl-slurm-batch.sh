#!/bin/bash
#SBATCH --job-name=104
#SBATCH --account=uoa00424
#SBATCH --mail-user=hjin317@aucklanduni.ac.nz
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8192
#SBATCH --time=20:00:00
#SBATCH --array=4401-4430

module load MATLAB/2017b
srun matlab -nodesktop -nosplash -r EEGlab_102_Pre_Batch_v3 $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_JOB_ID
