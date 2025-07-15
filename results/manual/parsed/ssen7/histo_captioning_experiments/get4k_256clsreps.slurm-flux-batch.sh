#!/bin/bash
#FLUX: --job-name=conspicuous-poo-2307
#FLUX: --queue=bii-gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load singularity pytorch/1.10.0
singularity run --nv $CONTAINERDIR/pytorch-1.10.0.sif /home/ss4yd/vision_transformer/captioning_vision_transformer/generate4k_256clsreps.py
