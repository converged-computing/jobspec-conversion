#!/bin/bash
#FLUX: --job-name=train_gpt
#FLUX: -N=4
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --priority=16

export MASTER_ADDR='$(hostname -s)'
export MASTER_PORT='$(shuf -i 10000-65500 -n 1)'
export WORLD_SIZE='16'

export MASTER_ADDR=$(hostname -s)
export MASTER_PORT=$(shuf -i 10000-65500 -n 1)
export WORLD_SIZE=16
LR=0.0003
OPTIMIZER='Adam'
srun python -u /scratch/eo41/vqgan-gpt/train.py \
	--save_dir '/scratch/eo41/vqgan-gpt/gpt_pretrained_models' \
	--batch_size 6 \
	--gpt_config 'GPT_gimel' \
	--num_workers 16 \
	--print_freq 15000 \
	--optimizer ${OPTIMIZER} \
	--lr ${LR} \
	--seed ${SLURM_ARRAY_TASK_ID} \
	--data_path '/scratch/eo41/data/saycam/Y_5fps_300s_{000000..000002}.tar' \
	--vqconfig_path '/scratch/eo41/vqgan-gpt/vqgan_pretrained_models/y_32x32_8192.yaml' \
	--vqmodel_path '/scratch/eo41/vqgan-gpt/vqgan_pretrained_models/y_32x32_8192.ckpt' \
	--resume '/scratch/eo41/vqgan-gpt/gpt_pretrained_models/y_gimel.pt' \
	--save_prefix 'y_gimel'
echo "Done"
