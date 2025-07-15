#!/bin/bash
#FLUX: --job-name=RUN_LR_PULL_STATS
#FLUX: --queue=batch
#FLUX: -t=36000
#FLUX: --priority=16

MATLAB=matlab
MATOPT=' -nojvm -nodisplay -nosplash'
echo "Executing srun of run_pull_stats"
$MATLAB $MATOPT -r "addpath('~/git/pull_stats_DEV/cris','~/git/pull_stats_DEV/cris/scripts'); run_pull_stats_clear($1); exit"
echo "Finished with srun of run_pull_stats"
