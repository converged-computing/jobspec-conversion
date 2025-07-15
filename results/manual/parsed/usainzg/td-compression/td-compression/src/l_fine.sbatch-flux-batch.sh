#!/bin/bash
#FLUX: --job-name=tdcomp
#FLUX: -c=4
#FLUX: --queue=KAT
#FLUX: --priority=16

export WANDB_API_KEY='b36e9889bae82cb5e6c3d8cb86e29df222fac76d'
export WANDB_SILENT='true'
export WANDB__SERVICE_WAIT='300'

export WANDB_API_KEY='b36e9889bae82cb5e6c3d8cb86e29df222fac76d'
export WANDB_SILENT=true
export WANDB__SERVICE_WAIT=300
let ind=1
for model in resnet18 resnet34 resnet50 vgg11 vgg16 vgg19; do
	for decomp in cp tucker tt; do
		for tn_rank in 0.1 0.2 0.5 0.8; do
			eval " options[${ind}]=' --model ${model} --tn-decomp ${decomp} --tn-rank ${tn_rank} --finetune 1' "
			#echo ${options[${ind}]}
			let ind=$ind+1
		done
	done
done
priscilla exec python3 run_finetune.py ${options[${SLURM_ARRAY_TASK_ID}]}
