#!/bin/bash
#FLUX: --job-name=i_gp_w/o_l2
#FLUX: -c=20
#FLUX: -t=172800
#FLUX: --priority=16

module purge
singularity exec --nv \
	    --overlay /scratch/mr6744/pytorch/overlay-25GB-500K.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
	    /bin/bash -c "source /ext3/env.sh; python /scratch/mr6744/pytorch/ddpm_deblurring/trainer_conditioned_pretrained_init.py \
		--port 53 --batch_size 64 --sample_size 32 --d_lr 1e-4 --g_lr 1e-4 --threshold 0.02 --l2_loss 0. \
		--dataset_t gopro --dataset_v gopro --ckpt_step 989000 --ckpt_path 08242023_053010 \
		--num_workers 8 --multiplier 175 --sampling_interval 46_000 --random_seed 7 --name gopro_w/o_l2_pretrained_init \
		--wandb --hpc --sample --crop_eval --ckpt_metrics"
