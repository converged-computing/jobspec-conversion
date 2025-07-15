#!/bin/bash
#FLUX: --job-name=resnet34-pl
#FLUX: -c=4
#FLUX: -t=30600
#FLUX: --priority=16

module purge
module load Singularity
singularity exec --bind /nesi/project/uoa03709/work-dir/py-data:/var/inputdata --cleanenv --nv /nesi/project/uoa03709/containers/sif/smp-cv_0.2.0.sif python /var/inputdata/train_pl34.py
