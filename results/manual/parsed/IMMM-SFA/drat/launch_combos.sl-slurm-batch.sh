#!/bin/bash
#SBATCH --job-name=drat_combos
#SBATCH --account=im3
#SBATCH --mail-user=travis.thurber@pnnl.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=7-00:00:00
#SBATCH --partition=shared
#SBATCH --array=1-27

module purge
module load gcc/11.2.0
module load R/4.0.2
Rscript drat_combos.R $SLURM_ARRAY_TASK_ID
