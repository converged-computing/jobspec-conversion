#!/bin/bash
#FLUX: --job-name=jobName
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --priority=16

module purge
singularity exec --nv \
        --overlay /vast/work/public/ml-datasets/imagenet/imagenet-val.sqf:ro \
        --overlay /vast/work/public/ml-datasets/imagenet/imagenet-train.sqf:ro \
	    --overlay /scratch/sca321/conda/simple2/overlay-50G-10M.ext3:ro \
	    /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
	    /bin/bash -c "source /ext3/env.sh; python attacks_optimized.py -o alloutputseps4 -mt $1 --gpu 0 -dpath $2  -it $3 -mp $4 -ni $5 -clip -lr $6 -ps $7 -si $8 -eps $9;"
