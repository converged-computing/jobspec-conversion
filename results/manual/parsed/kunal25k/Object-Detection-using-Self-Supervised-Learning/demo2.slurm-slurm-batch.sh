#!/bin/bash
#FLUX: --job-name=demo
#FLUX: -t=600
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/tmp/$USER'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
module load python/intel/3.8.6
singularity exec --nv \
--bind /scratch \
--overlay labeled.sqsh \
/scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
/bin/bash -c "
python demo.py
"
