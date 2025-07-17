#!/bin/bash
#FLUX: --job-name=train-chess
#FLUX: --queue=bii-gpu
#FLUX: -t=259200
#FLUX: --urgency=16

date
nvidia-smi
module purge
module load singularity tensorflow cuda cudatoolkit cudnn gcc openmpi python
source ./ENV/bin/activate
time singularity exec --nv $CONTAINERDIR/tensorflow-2.10.0.sif \
    python train.py --save-dir saved_model # --load-dir saved_model\
date
