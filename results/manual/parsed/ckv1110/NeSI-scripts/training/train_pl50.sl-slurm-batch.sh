#!/bin/bash
#FLUX: --job-name=resnet50-mc
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=17400
#FLUX: --urgency=16

module purge
module load Singularity
singularity exec --bind /nesi/project/uoa03709/work-dir/py-data:/var/inputdata --cleanenv --nv /nesi/project/uoa03709/containers/sif/smp-cv_0.2.0.sif python /var/inputdata/train_UPP_resnet50.py
