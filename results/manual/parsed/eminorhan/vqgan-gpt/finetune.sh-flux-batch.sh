#!/bin/bash
#FLUX: --job-name=finetune_gpt
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --priority=16

export MASTER_ADDR='$(hostname -s)'
export MASTER_PORT='$(shuf -i 10000-65500 -n 1)'
export WORLD_SIZE='2'

export MASTER_ADDR=$(hostname -s)
export MASTER_PORT=$(shuf -i 10000-65500 -n 1)
export WORLD_SIZE=2
module purge
module load cuda/11.6.2
LR=0.0003
OPTIMIZER='Adam'
srun python -u /scratch/eo41/vqgan-gpt/finetune.py \
	--save_dir '/scratch/eo41/vqgan-gpt/gpt_finetuned_models' \
	--batch_size 8 \
	--gpt_config 'GPT_gimel' \
	--num_workers 16 \
	--optimizer ${OPTIMIZER} \
	--lr ${LR} \
	--seed ${SLURM_ARRAY_TASK_ID} \
	--data_path '/vast/eo41/data/konkle_ood/vehicle_vs_nonvehicle/nonvehicle' \
	--vqconfig_path '/scratch/eo41/vqgan-gpt/vqgan_pretrained_models/say_32x32_8192.yaml' \
	--vqmodel_path '/scratch/eo41/vqgan-gpt/vqgan_pretrained_models/say_32x32_8192.ckpt' \
	--resume '' \
	--save_freq 50 \
	--save_prefix 'scratch_gimel_konkle_nonvehicle'
echo "Done"
