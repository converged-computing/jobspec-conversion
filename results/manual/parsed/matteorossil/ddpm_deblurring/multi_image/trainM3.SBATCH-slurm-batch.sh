#!/bin/bash
#SBATCH --job-name=gp_m_w/
#SBATCH --output=/scratch/mr6744/pytorch/outputs_slurm/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:2
#SBATCH --mem=30GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv \
	    --overlay /scratch/mr6744/pytorch/overlay-25GB-500K.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
	    /bin/bash -c "source /ext3/env.sh; python /scratch/mr6744/pytorch/ddpm_deblurring/multi_image/trainer_multi_full.py \
		--port 57 --batch_size 16 --sample_size 16 --d_lr 1e-4 --g_lr 1e-4 --threshold 0.03 --l2_loss 0.1 --dataset_t gopro2 \
		--dataset_v gopro2 --num_workers 8 --multiplier 77 --sampling_interval 10_120 --name gopro_multi_image_with_l2 \
		--wandb --hpc --sample --crop_eval --ckpt_metrics --ckpt_step 1386440 --ckpt_path 08222023_154246"
