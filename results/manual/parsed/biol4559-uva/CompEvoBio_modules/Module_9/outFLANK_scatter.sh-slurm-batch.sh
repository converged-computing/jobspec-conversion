#!/bin/bash
#SBATCH --job-name=fst
#SBATCH --account=biol4559-aob2x
#SBATCH --output=/scratch/aob2x/logs/fst.%A_%a.out
#SBATCH --error=/scratch/aob2x/logs/fst.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=5G
#SBATCH --time=00:15:00
#SBATCH --partition=standard

  module load intel/18.0 intelmpi/18.0 R/4.0.3
  Rscript --vanilla FULL_PATH_TO-outFLANK_Fst.R ${SLURM_ARRAY_TASK_ID}
