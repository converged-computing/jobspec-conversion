#!/bin/bash
#FLUX: --job-name=fugly-egg-7475
#FLUX: -N=3
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
singularity exec --nv \
	    --overlay /scratch/nn1331/whisper/whisper.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
	    /bin/bash -c "source /ext3/env.sh; python whisper.py"
