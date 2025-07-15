#!/bin/bash
#FLUX: --job-name=swampy-cupcake-9827
#FLUX: -c=8
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR                            # Change to working directory
conda activate ldm
CUDA_VISIBLE_DEVICES=0,1,2,3 python main.py --base configs/latent-diffusion/midi-vq-4-b.yaml -r -t --gpus 0,1,2,3
