#!/bin/bash
#SBATCH --job-name=gp_w/o_l2
#SBATCH --output=/scratch/mr6744/pytorch/outputs_slurm/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:2
#SBATCH --mem=40GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv \
	    --overlay /scratch/mr6744/pytorch/overlay-25GB-500K.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
	    /bin/bash -c "source /ext3/env.sh; python /scratch/mr6744/pytorch/ddpm_deblurring/trainer_conditioned.py \
		--port 50 --batch_size 64 --sample_size 32 --d_lr 1e-4 --g_lr 1e-4 --threshold 0.02 --l2_loss 0. \
		--dataset_t gopro --dataset_v gopro --ckpt_step 1914450 --ckpt_path 08152023_215404 \
		--num_workers 8 --multiplier 99 --sampling_interval 19_518 --random_seed 7 --name gopro_w/o_l2 \
		--wandb --hpc --sample --crop_eval --ckpt_metrics"
