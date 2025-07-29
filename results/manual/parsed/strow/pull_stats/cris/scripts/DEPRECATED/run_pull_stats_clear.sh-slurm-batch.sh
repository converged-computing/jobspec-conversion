#!/bin/bash
#SBATCH --job-name=RUN_LR_PULL_STATS
#SBATCH --account=pi_strow
#SBATCH --output=/home/sbuczko1/LOGS/sbatch/run_cris_pull_stats-%A_%a.out
#SBATCH --error=/home/sbuczko1/LOGS/sbatch/run_cris_pull_stats-%A_%a.err
#SBATCH --mail-user=sbuczko1@umbc.edu
#SBATCH --mail-type=TIME_LIMIT_50
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=18000
#SBATCH --time=10:00:00
#SBATCH --qos=medium+
#SBATCH --array=0-7

MATLAB=matlab
MATOPT=' -nojvm -nodisplay -nosplash'
echo "Executing srun of run_pull_stats"
$MATLAB $MATOPT -r "addpath('~/git/pull_stats_DEV/cris','~/git/pull_stats_DEV/cris/scripts'); run_pull_stats_clear($1); exit"
echo "Finished with srun of run_pull_stats"
