#!/bin/bash
#FLUX: --job-name=torch
#FLUX: -c=16
#FLUX: -t=43200
#FLUX: --priority=16

module purge
singularity exec --nv \
            --overlay /scratch/sp7238/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
            /bin/bash -c "source /ext3/env.sh; python train.py"
