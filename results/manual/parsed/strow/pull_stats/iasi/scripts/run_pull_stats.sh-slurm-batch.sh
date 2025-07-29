#!/bin/bash
#SBATCH --job-name=RUN_IASI_PULL_STATS_CLR
#SBATCH --account=pi_strow
#SBATCH --output=/home/sbuczko1/LOGS/sbatch/pull_stats_iasi_clr-%A_%a.out
#SBATCH --error=/home/sbuczko1/LOGS/sbatch/pull_stats_iasi_clr-%A_%a.err
#SBATCH --mail-user=sbuczko1@umbc.edu
#SBATCH --mail-type=TIME_LIMIT_50
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=28000
#SBATCH --time=08:00:00
#SBATCH --partition=high_mem
#SBATCH --qos=medium+
#SBATCH --array=0-12

MATLAB=matlab
MATOPT=' -nojvm -nodisplay -nosplash'
JOBSTEP=0
echo "Executing srun of run_pull_stats"
$MATLAB $MATOPT -r "addpath('~/git/pull_stats_DEV/iasi');\
                    addpath('~/git/rtp_prod2_DEV/util');\
                    addpath('~/git/pull_stats_DEV/util');\
                    addpath('~/git/pull_stats_DEV/iasi/util');\
                    cfg=ini2struct('$2');\
                    run_pull_stats($1, cfg);\
                    exit"
echo "Finished with srun of run_pull_stats"
