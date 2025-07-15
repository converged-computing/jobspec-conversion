#!/bin/bash
#FLUX: --job-name=torch
#FLUX: -t=3600
#FLUX: --priority=16

module purge
singularity exec --nv \
	    --overlay /scratch/wbg231/capstone_env/overlay-15GB-500K.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
	    /bin/bash -c "source /ext3/env.sh; python txgn/example.py"
