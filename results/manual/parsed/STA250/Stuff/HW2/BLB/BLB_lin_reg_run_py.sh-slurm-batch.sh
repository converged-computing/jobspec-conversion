#!/bin/bash
#SBATCH --job-name=blbfit
#SBATCH --output=dump/BLB_lin_reg_job_%j.out
#SBATCH --error=dump/BLB_lin_reg_job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6000

module load pymods/2.7
module load numpy
srun python BLB_lin_reg_job.py -i ${SLURM_ARRAYID}
