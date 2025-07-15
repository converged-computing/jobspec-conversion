#!/bin/bash
#FLUX: --job-name='mh'
#FLUX: -c=4
#FLUX: -t=18000
#FLUX: --priority=16

export HF_TOKEN='$(cat hf_token.txt)'

export HF_TOKEN=$(cat hf_token.txt)
overlay=/scratch/ad6489/pyexample/overlay2
img=/scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif
singularity exec --nv \
	--overlay $overlay:ro \
	$img \
    /bin/bash -c \
	"source /ext3/env.sh; \
	python mh.py"
