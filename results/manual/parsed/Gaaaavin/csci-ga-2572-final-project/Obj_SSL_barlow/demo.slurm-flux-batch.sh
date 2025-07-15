#!/bin/bash
#FLUX: --job-name=demo
#FLUX: -c=10
#FLUX: -t=345600
#FLUX: --urgency=16

singularity exec --nv \
--overlay /scratch/hrr288/hrr_env/pytorch1.7.0-cuda11.0.ext3:ro \
--overlay /scratch/xl3136/dl-sp22-final-project/dataset/unlabeled_224.sqsh \
--overlay /scratch/xl3136/dl-sp22-final-project/dataset/labeled.sqsh \
/scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif \
/bin/bash -c "
source /ext3/env.sh; python3 main.py "
