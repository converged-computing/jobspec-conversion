#!/bin/bash
#FLUX: --job-name=frame_pred
#FLUX: -c=8
#FLUX: -t=90000
#FLUX: --urgency=16

singularity exec --nv \
	    --overlay /scratch/tk3309/DL24/overlay-50G-10M.ext3:rw \
	    /scratch/tk3309/DL24/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif \
	    /bin/bash -c "source /ext3/env.sh; python /scratch/tk3309/mask_dl_final/train.py"
