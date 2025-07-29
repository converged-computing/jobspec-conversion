#!/bin/bash
#FLUX: --job-name=gpsl5_100
#FLUX: -c=32
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/doppler_prn'

module load python/3.9
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/doppler_prn
cd $SLURM_SUBMIT_DIR
lscpu
mkdir results
python3 run.py --s $SLURM_ARRAY_TASK_ID --f 4.5e3 --t 9.77517107e-8 --m 31 --n 10230 --gs 100 --maxit 1_000_000_000 --name "results/gpsl5_100" --log 350_000 --obj
