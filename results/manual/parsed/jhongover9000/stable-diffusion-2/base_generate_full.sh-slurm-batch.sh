#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem-per-cpu=40G
#SBATCH --time=3-00:30:00
#SBATCH --partition=nvidia

FILES=(/scratch/jhh508/stable-diffusion-2/*)
module purge
pwd
cd /scratch/jhh508/stable-diffusion-2/
eval "$(conda shell.bash hook)"
conda init bash
conda activate stable-diff
module load gcc
python scripts/guidance_inference_combo_neg.py --csv webDiffusion.csv --config configs/stable-diffusion/v2-inference.yaml --ckpt 512-base-ema.ckpt --fixed_code --negFile
