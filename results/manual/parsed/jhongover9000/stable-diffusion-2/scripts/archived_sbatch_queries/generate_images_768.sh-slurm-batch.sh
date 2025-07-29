#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem-per-cpu=40G
#SBATCH --time=3-00:30:00

FILES=(/scratch/jhh508/stable-diffusion-2/*)
module purge
pwd
cd /scratch/jhh508/stable-diffusion-2/
eval "$(conda shell.bash hook)"
conda init bash
conda activate stable-diff
module load gcc
python scripts/text2imgCombo_TextFileInput.py --csv webDiffusion.csv --config configs/stable-diffusion/v2-inference-v.yaml --ckpt 768-v-ema.ckpt --fixed_code --seed 979779  --W 768 --H 768
python scripts/text2imgCombo_TextFileInput.py --csv webDiffusion.csv --config configs/stable-diffusion/v2-inference-v.yaml --ckpt 768-v-ema.ckpt --fixed_code --seed 1412412  --W 768 --H 768
python scripts/text2imgCombo_TextFileInput.py --csv webDiffusion.csv --config configs/stable-diffusion/v2-inference-v.yaml --ckpt 768-v-ema.ckpt --fixed_code --seed 89313  --W 768 --H 768
