#!/bin/bash
#FLUX: --job-name=frigid-plant-9532
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: --urgency=16

module load miniconda/3 cuda/11.7
conda activate edm
python fid.py ref --data=/home/mila/k/karam.ghanem/scratch/datasets/imagenet-64x64.zip --dest=/home/mila/k/karam.ghanem/scratch/datasets/imagenet-64x64.npz
cp $SLURM_TMPDIR  /network/scratch/k/karam.ghanem
