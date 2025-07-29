#!/bin/bash
#SBATCH --job-name=Facke_ILVR
#SBATCH --output=log.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=10-10:00:00
#SBATCH --partition=gpu

module load anaconda3/2019.07
source activate pytorch_1.11
python -u benchmark.py --benchmark_skip 4 --benchmark_coarse 64 --benchmark_fine 320 --attention_resolutions 16 --diffusion_steps 1000 --dropout 0.0 --image_size 256 --learn_sigma --noise_schedule linear --num_channels 128 --num_head_channels 64 --num_res_blocks 1 --resblock_updown --use_scale_shift_norm --timestep_respacing 100 --DDPM_pth ./utils/guided_diffusion/models/ffhq_10m.pt --down_N 32 --range_t 20 --clip_denoised --batchSize 32 --name Facke_finetune_DDPM_lr5e-6 --model ILVR
