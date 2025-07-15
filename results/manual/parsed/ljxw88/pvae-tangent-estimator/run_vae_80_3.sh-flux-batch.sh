#!/bin/bash
#FLUX: --job-name=peachy-pastry-6832
#FLUX: -t=43200
#FLUX: --urgency=16

module load pytorch/1.4.0-py36-cuda90
module load torchvision/0.5.0-py36
python3 pvae/main.py --model mnist --manifold PoincareBall --c 0.7  --latent-dim 80 --hidden-dim 600 --prior WrappedNormal --posterior WrappedNormal --dec Geo     --enc Wrapped --lr 5e-4 --epochs 80 --save-freq 80 --batch-size 128 --iwae-samples 5000
