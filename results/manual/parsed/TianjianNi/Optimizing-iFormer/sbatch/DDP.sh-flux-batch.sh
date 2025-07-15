#!/bin/bash
#FLUX: --job-name=DDP
#FLUX: -c=4
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
singularity exec --nv \
            --overlay /scratch/tn2151/pytorch-example/overlay-10GB-400K.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
            /bin/bash -c "source /ext3/env.sh;
        python main_DDP.py;"
