#!/bin/bash
#FLUX: --job-name=astute-hobbit-2545
#FLUX: --urgency=16

module purge
singularity exec --nv \
    --overlay /home/ch4407/py/overlay-15GB-500K.ext3:ro \
    /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif* \
    /bin/bash -c \
    "source /ext3/env.sh; venv lbc; cd /home/ch4407/lbc/scripts; \
    python train.py 100_000 -c 4 -l $SLURM_ARRAY_TASK_ID --camera r; \
    python train.py 100_000 -c 4 -l $SLURM_ARRAY_TASK_ID --camera b;"
