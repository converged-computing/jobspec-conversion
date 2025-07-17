#!/bin/bash
#FLUX: --job-name=ranked_SACrit_BayesAnneal
#FLUX: -t=7200
#FLUX: --urgency=16

echo "Starting job $SLURM_ARRAY_TASK_ID"
python3 complexity_hist_revisions.py "80"				1000 		1000        $SLURM_ARRAY_TASK_ID    "SA"    1   0   10  0 "bmod"
python3 complexity_hist_revisions.py "30"				1000 		1000 		$SLURM_ARRAY_TASK_ID    "SA"    1   0   10  0 "bmod"
