#!/bin/bash
#FLUX: --job-name=leo_10k_10
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/doppler_prn'

module load python/3.9
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/doppler_prn
cd $SLURM_SUBMIT_DIR
lscpu
mkdir results
python3 run.py --s $SLURM_ARRAY_TASK_ID --f 29.6e3 --t 2e-7 --m 300 --n 10007 --gs 10 --maxit 1_000_000_000 --name "results/leo_10k_10" --log 35_000 --no-obj
