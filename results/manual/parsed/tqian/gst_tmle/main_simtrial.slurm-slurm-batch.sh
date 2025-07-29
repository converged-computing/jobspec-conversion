#!/bin/bash
#SBATCH --job-name=main_simtrial
#SBATCH --output=output/main_simtrial_%A_%a.out
#SBATCH --error=output/main_simtrial_%A_%a.err
#SBATCH --mail-user=qiantianchen@fas.harvard.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16000
#SBATCH --time=16:40:00
#SBATCH --partition=murphy

export R_LIBS_USER='$HOME/apps/R_3.6.1:$R_LIBS_USER'

module load gcc/8.2.0-fasrc01 openmpi/3.1.1-fasrc01 R/3.6.1-fasrc01 # load R
export R_LIBS_USER=$HOME/apps/R_3.6.1:$R_LIBS_USER
R CMD BATCH /n/home00/tqian/gst_tmle/main_simtrial.R /n/home00/tqian/gst_tmle/Rout/main_simtrial.Rout.${SLURM_ARRAY_TASK_ID}
