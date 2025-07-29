#!/bin/bash
#SBATCH --mail-user=hkumawat3@gatech.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:A100:4
#SBATCH --mem=40G
#SBATCH --time=02:00:00

cd $SLURM_SUBMIT_DIR                            # Change to working directory
conda activate ldm
CUDA_VISIBLE_DEVICES=0,1,2,3 python main.py --base configs/latent-diffusion/midi-vq-4-b.yaml -r -t --gpus 0,1,2,3
