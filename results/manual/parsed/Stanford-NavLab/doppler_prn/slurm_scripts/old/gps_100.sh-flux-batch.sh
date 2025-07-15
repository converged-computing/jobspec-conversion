#!/bin/bash
#FLUX: --job-name="gps_100"
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --priority=16

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/doppler_prn'

module load python/3.9
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/doppler_prn
cd $SLURM_SUBMIT_DIR
lscpu
mkdir results
python3 run.py --s $SLURM_ARRAY_TASK_ID --f 6e3 --t 9.77517107e-7 --m 31 --n 1023 --gs 100 --maxit 10_000_000 --name "results/gps_100" --log 10_000 --obj
