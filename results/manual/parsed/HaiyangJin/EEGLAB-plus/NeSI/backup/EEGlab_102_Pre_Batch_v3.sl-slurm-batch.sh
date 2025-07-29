#!/bin/bash
#SBATCH --job-name=102
#SBATCH --account=uoa00424
#SBATCH --mail-user=hjin317@aucklanduni.ac.nz
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=10240
#SBATCH --time=20:00:00
#SBATCH --partition=bigmem
#SBATCH --array=2401-2430

module load MATLAB/2017b
matlab -nodesktop -nosplash -r EEGlab_102_Pre_Batch_v3 $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_JOB_ID
