#!/bin/bash
#FLUX: --job-name=bricky-nunchucks-8323
#FLUX: -c=4
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
python scripts/guidance_inference_combo_neg.py --csv webDiffusion.csv --config configs/stable-diffusion/v2-inference.yaml --ckpt 512-base-ema.ckpt --fixed_code --negFile
