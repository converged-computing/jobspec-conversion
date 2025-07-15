#!/bin/bash
#FLUX: --job-name=train_mae_s
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --priority=16

export MASTER_ADDR='$(hostname -s)'
export MASTER_PORT='$(shuf -i 10000-65500 -n 1)'
export WORLD_SIZE='1'

export MASTER_ADDR=$(hostname -s)
export MASTER_PORT=$(shuf -i 10000-65500 -n 1)
export WORLD_SIZE=1
DATAS=(
	"S_5fps_300s_{000000..000003}" 
	)
SAVES=(
	"s" 
	)
DATA=${DATAS[$SLURM_ARRAY_TASK_ID]}
SAVE=${SAVES[$SLURM_ARRAY_TASK_ID]}
echo $DATA
echo $SAVE
srun python -u /scratch/eo41/mae/train_mae.py \
	--model 'mae_vit_huge_patch14' \
	--resume /scratch/eo41/mae/models_vith14/s_vith14_checkpoint.pth \
	--mask_ratio 0.8 \
	--batch_size_per_gpu 256 \
	--num_workers 16 \
	--lr 0.0001 \
	--min_lr 0.0001 \
	--weight_decay 0.0 \
	--output_dir /scratch/eo41/mae/models_vith14 \
	--data_path /scratch/eo41/data/saycam/${DATA}.tar \
	--save_prefix "${SAVE}_vith14"
echo "Done"
