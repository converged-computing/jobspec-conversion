#!/bin/bash
#SBATCH --output=kernel_alignment.out
#SBATCH --error=kernel_alignment.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=6000
#SBATCH --time=12:00:00
#SBATCH --partition=scavenge

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load MATLAB/2018b
matlab -nodisplay -nosplash -nodesktop -r "root_path='/gpfs/ysm/project/ahf38/Antonio_VocalMat/VocalMat2'; work_dir = '"$FOLDER"', analysis_path = fullfile(root_path,'vocalmat_analysis'); cd(analysis_path); run('kernel_alignment_cluster.m'), "
