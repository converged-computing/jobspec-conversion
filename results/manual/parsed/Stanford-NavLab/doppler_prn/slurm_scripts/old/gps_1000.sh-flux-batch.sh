#!/bin/bash
#FLUX: --job-name=gps_1000
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
python3 run.py --s $SLURM_ARRAY_TASK_ID --f 6e3 --t 9.77517107e-7 --m 31 --n 1023 --gs 1000 --maxit 10_000_000 --name "results/gps_1000" --log 10_000 --obj
