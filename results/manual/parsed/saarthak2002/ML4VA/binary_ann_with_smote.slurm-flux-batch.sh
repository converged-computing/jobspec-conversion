#!/bin/bash
#FLUX: --job-name=salted-parsnip-3346
#FLUX: -c=8
#FLUX: --queue=bii-gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load anaconda/2020.11-py3.8
module load singularity tensorflow/2.10.0
singularity run --nv $CONTAINERDIR/tensorflow-2.10.0.sif binary_ann_with_smote.py
