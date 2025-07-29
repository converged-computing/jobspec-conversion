#!/bin/bash
#FLUX: --job-name=lunar_pnt
#FLUX: -c=32
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/doppler_prn'

module load python/3.9
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/doppler_prn
cd $SLURM_SUBMIT_DIR
lscpu
mkdir results
python3 run.py --s 0 --f 9.5e3 --t 1.941747572815534e-7 --m 8 --n 5113 --doppreg $SLURM_ARRAY_TASK_ID --maxit 1_000_000_000 --name "results/lunar_pnt" --log 1_000 --obj --obj_v_freq
