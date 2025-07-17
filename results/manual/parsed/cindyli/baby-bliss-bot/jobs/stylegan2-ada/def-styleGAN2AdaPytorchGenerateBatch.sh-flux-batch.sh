#!/bin/bash
#FLUX: --job-name=StyleGAN-2
#FLUX: -t=60
#FLUX: --urgency=16

module load nixpkgs/16.09  intel/2018.3  cuda/10.0.130 cudnn/7.5
source ~/BlissStyleGAN/StyleGAN2/pytorch/bin/activate
MODEL_FILE=./pytorch-ada-results/00003-preppedBlissSingleCharGrey-auto1-resumecustom/network-snapshot-000120.pkl
OUTPUT_DIR=~/BlissStyleGAN/StyleGAN2/pytorch-ada-generate
mkdir -p "$OUTPUT_DIR"
python ~/BlissStyleGAN/StyleGAN2/stylegan2-ada-pytorch/generate.py --outdir="$OUTPUT_DIR" --trunc=0.5 --seeds=600-605 --network="$MODEL_FILE"
