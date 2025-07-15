#!/bin/bash
#FLUX: --job-name=StyleGAN-2
#FLUX: -t=1440
#FLUX: --urgency=16

module load nixpkgs/16.09  intel/2018.3  cuda/10.0.130 cudnn/7.5
source ~/BlissStyleGAN/StyleGAN2/pytorch/bin/activate
echo -n "SLURM temporary directory: "
echo "$SLURM_TMPDIR"
echo
DATA_DIR="$SLURM_TMPDIR/preppedBlissSingleCharGrey"
tar xf ~/BlissStyleGAN/StyleGAN2/preppedBliss4Pytorch.tar -C "$SLURM_TMPDIR"
ls -R "$DATA_DIR"
OUTPUT_DIR=./pytorch-ada-results
mkdir -p "$OUTPUT_DIR"
python ~/BlissStyleGAN/StyleGAN2/stylegan2-ada-pytorch/train.py --outdir="$OUTPUT_DIR" --data="$DATA_DIR" --snap=10
