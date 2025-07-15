#!/bin/bash
#FLUX: --job-name=16B_review
#FLUX: -c=2
#FLUX: -t=172799
#FLUX: --urgency=16

module purge
singularity exec --nv \
            --overlay /vast/bc3194/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif\
            /bin/bash -c "source /ext3/env.sh; export TRANSFORMERS_CACHE='/vast/bc3194/huggingface_cache'; python -u 16B.py"
