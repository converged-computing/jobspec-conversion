#!/bin/bash
#FLUX: --job-name=crusty-lentil-0385
#FLUX: -t=216000
#FLUX: --urgency=16

echo "slurm task ID = $SLURM_ARRAY_TASK_ID used as hmax"
echo "start of SNaQ parallel runs on $(hostname)"
/home/jg2334/download/julia-1.9.4/bin/julia --history-file=no -- runSNaQ.jl $SLURM_ARRAY_TASK_ID 30 > net$SLURM_ARRAY_TASK_ID_30runs.screenlog 2>&1
echo "end of SNaQ run ..."
