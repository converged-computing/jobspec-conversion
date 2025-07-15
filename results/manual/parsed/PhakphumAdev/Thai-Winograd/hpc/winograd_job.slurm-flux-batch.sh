#!/bin/bash
#FLUX: --job-name=winograd
#FLUX: --queue=n1s8-v100-1
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
cd /home/pa2497/Thai-Winograd
OVERLAY_FILE=/scratch/pa2497/overlay-25GB-500K.ext3:rw
SINGULARITY_IMAGE=/scratch/pa2497/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif
singularity exec --nv \
	    --overlay $OVERLAY_FILE $SINGULARITY_IMAGE \
	    /bin/bash -c "source /ext3/env.sh; bash hpc/run_evaluation.sh"
