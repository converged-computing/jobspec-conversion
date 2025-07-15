#!/bin/bash
#FLUX: --job-name=RUN_IASI_PULL_STATS_CLR
#FLUX: --queue=high_mem
#FLUX: -t=28800
#FLUX: --priority=16

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
