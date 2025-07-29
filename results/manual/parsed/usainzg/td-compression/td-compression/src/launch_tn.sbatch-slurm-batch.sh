#!/bin/bash
#FLUX: --job-name=tdcomp
#FLUX: -c=4
#FLUX: --queue=KAT
#FLUX: --urgency=16

export WANDB_API_KEY='b36e9889bae82cb5e6c3d8cb86e29df222fac76d'
export WANDB_SILENT='true'
export WANDB__SERVICE_WAIT='300'

export WANDB_API_KEY='b36e9889bae82cb5e6c3d8cb86e29df222fac76d'
export WANDB_SILENT=true
export WANDB__SERVICE_WAIT=300
let ind=1
for model in resnet18 resnet34 resnet50; do
	for decomp in cp tucker tt; do
		for ratio in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9; do
		    eval " options[${ind}]=' --model ${model} --tn-implementation factorized --tn-decomp ${decomp} --tn-rank ${ratio} ' "
		    #echo ${options[${ind}]}
		    #echo $ind
		    let ind=$ind+1
		done
	done
done
priscilla exec python3 run.py ${options[${SLURM_ARRAY_TASK_ID}]}
