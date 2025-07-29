#!/bin/bash
#SBATCH --job-name=FIT_MA_SIM_PRIOR
#SBATCH --output=jobmessages/job%j-%a.out
#SBATCH --error=jobmessages/jobERR%j-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:24:00
#SBATCH --partition=shared
#SBATCH --array=1-960

export R_LIBS_USER='$HOME/apps/R_4.0.2'

echo $SLURM_ARRAY_TASK_ID
mkdir -p jobout/${SLURM_JOB_NAME}
module load gcc/9.3.0-fasrc01 #Load gcc
module load R/4.0.2-fasrc01 #Load R module
export R_LIBS_USER=$HOME/apps/R_4.0.2
R CMD BATCH --quiet --no-restore --no-save 4.sim_full/4.full_sim_recovery_cluster_sampsize_prior.R jobout/${SLURM_JOB_NAME}/OutSim_${SLURM_ARRAY_TASK_ID}.Rout
