#!/bin/bash
#FLUX: --job-name=10_lp_200K_deblur_new
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

export MASTER_PORT='$(shuf -i 10000-65500 -n 1)'
export WORLD_SIZE='$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))'
export MASTER_ADDR='$(hostname -s).hpc.nyu.edu'

export MASTER_PORT=$(shuf -i 10000-65500 -n 1)
export WORLD_SIZE=$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))
echo "WORLD_SIZE="$WORLD_SIZE
export MASTER_ADDR="$(hostname -s).hpc.nyu.edu"
echo "MASTER_ADDR="$MASTER_ADDR
module purge
srun \
	singularity exec --nv \
	--overlay /scratch/mr6744/pytorch/overlay-25GB-500K.ext3:ro \
    --overlay /vast/work/public/ml-datasets/imagenet/imagenet-train.sqf:ro \
    --overlay /vast/work/public/ml-datasets/imagenet/imagenet-val.sqf:ro \
	/scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
	/bin/bash -c "source /ext3/env.sh; python -u main_linprobe.py \
												--model vit_small_patch16 --cls_token \
												--finetune /vast/mr6744/pretrained_models2/200K_deblur/run3/checkpoint-999.pth \
												--batch_size 128 \
												--epochs 100 \
												--num_workers 16 \
												--output_dir /vast/mr6744/linear_evaluation/200K_deblur/fract10 \
												--log_dir /vast/mr6744/linear_evaluation/200K_deblur/fract10 \
												--blr 0.1 \
												--weight_decay 0.0 \
												--nb_classes 1000 \
												--data_path /imagenet \
												--frac_retained 0.1"
