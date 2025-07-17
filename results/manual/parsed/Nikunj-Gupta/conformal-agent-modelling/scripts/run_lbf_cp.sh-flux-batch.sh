#!/bin/bash
#FLUX: --job-name=arid-kerfuffle-4521
#FLUX: -c=6
#FLUX: -t=144000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1 #init weights fails otherwise (see https://github.com/pytorch/pytorch/issues/21956)'

source venv/bin/activate
export OMP_NUM_THREADS=1 #init weights fails otherwise (see https://github.com/pytorch/pytorch/issues/21956)
cp_update_timestep=${1}
runs=${SLURM_ARRAY_TASK_ID}
tensorboard --logdir="./debug_logs/lbf-exact-actions" --host 0.0.0.0 --load_fast false &
time python cam-lbf/exact-actions.py --cp_update_timestep=$cp_update_timestep --log_dir="./debug_logs/lbf-exact-actions" --seed=$runs 
