#!/bin/bash
#FLUX: --job-name=adorable-truffle-7633
#FLUX: -c=6
#FLUX: -t=72000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1 #init weights fails otherwise (see https://github.com/pytorch/pytorch/issues/21956)'

source venv/bin/activate
export OMP_NUM_THREADS=1 #init weights fails otherwise (see https://github.com/pytorch/pytorch/issues/21956)
cp_update_timestep=${1}
runs=${SLURM_ARRAY_TASK_ID}
time python conformal-action-prediction/conformal-rl.py --cp_update_timestep=$cp_update_timestep --log_dir="./debug_logs/cam-actions" --seed=$runs 
