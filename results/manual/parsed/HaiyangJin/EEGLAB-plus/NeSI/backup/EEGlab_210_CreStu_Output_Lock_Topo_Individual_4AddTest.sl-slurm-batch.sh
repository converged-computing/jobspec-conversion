#!/bin/bash
#SBATCH --job-name=210_Iscr
#SBATCH --account=uoa00424
#SBATCH --mail-user=hjin317@aucklanduni.ac.nz
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8192
#SBATCH --time=00:30:00
#SBATCH --partition=bigmem
#SBATCH --array=9500

module load MATLAB/2017b
srun matlab -nodesktop -nosplash -r EEGlab_210_CreStu_Output_Lock_Topo_v3 $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_JOB_ID
