#!/bin/bash
#FLUX: --job-name=gp_s_m_single
#FLUX: -c=20
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
singularity exec --nv \
	    --overlay /scratch/mr6744/pytorch/overlay-25GB-500K.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
	    /bin/bash -c "source /ext3/env.sh; python /scratch/mr6744/pytorch/ddpm_deblurring/trainer_conditioned.py \
		--port 52 --batch_size 16 --sample_size 16 --d_lr 1e-4 --g_lr 1e-4 --threshold 0.02 --l2_loss 0. \
		--dataset_t gopro_small_multi --dataset_v gopro_small_multi --ckpt_step 2556250 --ckpt_path 08152023_151117 \
		--num_workers 8 --multiplier 1000 --sampling_interval 18_750 --random_seed 7 --name gopro_small_multi_single_image \
		--wandb --hpc --sample --crop_eval --ckpt_metrics"
