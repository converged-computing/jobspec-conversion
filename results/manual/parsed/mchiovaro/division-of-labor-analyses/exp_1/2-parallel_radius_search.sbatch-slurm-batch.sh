#!/bin/bash
#SBATCH --job-name=slurm_exp_1
#SBATCH --output=slurm_output/out_exp_1.out
#SBATCH --error=slurm_output/err_exp_1.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=general
#SBATCH: --exclusive
#SBATCH --array=1-159

export SLURM_ARRAY_TASK_ID
module load gcc/11.3.0
module load r/4.2.1
module load gdal/3.6.1 gsl
source /gpfs/sharedfs1/admin/hpc2.0/apps/gdal/3.6.1/spack/share/spack/setup-env.sh
spack load gdal
echo $SLURM_ARRAY_TASK_ID": Running SLURM task"
Rscript $HOME/dissertation/exp_1/2-parallel_radius_search-nested.R
echo $SLURM_ARRAY_TASK_ID ": Job done"
