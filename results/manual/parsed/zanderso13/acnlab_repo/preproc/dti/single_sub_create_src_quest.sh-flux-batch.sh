#!/bin/bash
#FLUX: --job-name=dti_create_src
#FLUX: --queue=short
#FLUX: -t=600
#FLUX: --urgency=16

module load singularity/latest
action=src
source=$1
bval=$3
bvec=$2
recursive=0
echo "Work on the following folder: $1"
projdir=/projects/b1108
cd ${projdir}
singularity exec /home/zaz3744/ACNlab/software/singularity_images/dsi-studio-docker.sif /dsistudio/dsi_studio_64/dsi_studio --action=$action --source=$source --bval=${bval} --bvec=${bvec}
