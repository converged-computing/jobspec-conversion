#!/bin/bash
#FLUX: --job-name=f_i
#FLUX: -c=10
#FLUX: -t=54000
#FLUX: --priority=16

export PYTHONUSERBASE='$WORK/.local_flacon'
export GIT_PYTHON_REFRESH='quiet'

module load cpuarch/amd
module load pytorch-gpu/py3/2.0.1
export PYTHONUSERBASE=$WORK/.local_flacon
export GIT_PYTHON_REFRESH=quiet
args=()
for seed in 42 43 44 45 46
do 
    args+=("--seed ${seed}")
done
srun python train_and_generate_and_eval.py --lr=3e-5 --rank=32 --train_data_dir=data/lm_data/txt_data/interferencev2 --eval_data_json=data/lm_data/interference.json --eval_split=test ${args[${SLURM_ARRAY_TASK_ID}]}
