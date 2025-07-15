#!/bin/bash
#FLUX: --job-name=p
#FLUX: -c=2
#FLUX: -t=86400
#FLUX: --priority=16

module purge
DATA=$1
SPLIT=$2
LAYERS=$3
SHOT=$4
echo "start"
singularity exec --nv \
            --overlay /scratch/lg154/python36/python36.ext3:ro \
            --overlay /scratch/lg154/sseg/dataset/coco2014.sqf:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c " source /ext3/env.sh;
            python -m src.train_cca --config config_files/${DATA}_cca.yaml \
					 --opts train_split ${SPLIT} \
						    layers ${LAYERS} \
						    shot ${SHOT} \
					 > log_cca.txt 2>&1"
echo "finish"
