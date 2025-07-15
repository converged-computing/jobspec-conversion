#!/bin/bash
#FLUX: --job-name=monoscene
#FLUX: -c=10
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
cd /scratch/$USER/sscbench/MonoScene
singularity exec --nv \
	    --overlay /scratch/$USER/environments/monoscene.ext3:ro \
        --overlay /scratch/$USER/dataset/waymo/waymo.sqf:ro \
        --overlay /scratch/$USER/dataset/waymo/preprocess.sqf:ro \
	    /scratch/work/public/singularity/cuda10.2-cudnn8-devel-ubuntu18.04.sif \
	    /bin/bash -c "source /ext3/env.sh; 
        conda activate monoscene; 
        python monoscene/scripts/eval_waymo.py"
