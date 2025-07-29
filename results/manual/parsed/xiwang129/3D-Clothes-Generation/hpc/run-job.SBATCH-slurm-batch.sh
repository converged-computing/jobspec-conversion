#!/bin/bash
#FLUX: --job-name=python-training
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
singularity \
    exec --nv \
    --overlay /scratch/xw914/cv-final-flow/overlay-7.5GB-300K.ext3:ro \
    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
    /bin/bash -c "
source /ext3/env.sh
python modelTrain.py > log.txt
"
