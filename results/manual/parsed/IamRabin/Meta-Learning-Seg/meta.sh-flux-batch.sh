#!/bin/bash
#FLUX: --job-name=Meta
#FLUX: -c=4
#FLUX: -t=104400
#FLUX: --urgency=16

echo "== Starting run at $(date)"
echo "== Job ID: ${SLURM_JOBID}"
mkdir -p ~/output
srun python main.py --alg=iMAML
