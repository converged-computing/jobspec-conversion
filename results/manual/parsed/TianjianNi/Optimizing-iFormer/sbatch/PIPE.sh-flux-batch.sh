#!/bin/bash
#FLUX: --job-name=PIPE
#FLUX: -c=4
#FLUX: -t=36000
#FLUX: --priority=16

module purge
singularity exec --nv \
            --overlay /scratch/dy2242/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
            /bin/bash -c "source /ext3/env.sh;
            python main_PIPE.py
            "
