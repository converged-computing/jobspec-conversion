#!/bin/bash
#FLUX: --job-name=qlearning
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --urgency=16

singularity exec --nv --overlay $SCRATCH/OpenStreets/overlay-25GB-500K.ext3:rw /scratch/work/public/singularity/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate roads
python code/qlearning.py
"
