#!/bin/bash
#FLUX: --job-name=eval_cat
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
singularity exec \
	    --overlay /scratch/$USER/nbodykit.ext3:ro \
	    /scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif \
	    bash -c "source /ext3/env.sh; python /scratch/$USER/github/dl_halo/statistics/codes/eval_cat.py \
    --run-name '$1' --state-num $2 \
    --counts --cube-sz $3 --pixside 2048 "
