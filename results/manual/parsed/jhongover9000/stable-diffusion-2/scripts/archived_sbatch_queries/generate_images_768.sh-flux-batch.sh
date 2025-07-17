#!/bin/bash
#FLUX: --job-name=dinosaur-plant-0847
#FLUX: -n=2
#FLUX: -c=4
#FLUX: --queue=nvidia
#FLUX: -t=261000
#FLUX: --urgency=16

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
