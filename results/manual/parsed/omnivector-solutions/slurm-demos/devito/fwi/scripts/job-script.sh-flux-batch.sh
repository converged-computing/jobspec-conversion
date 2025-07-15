#!/bin/bash
#FLUX: --job-name=expressive-avocado-3762
#FLUX: --urgency=16

export DEVITO_LANGUAGE='openmp'
export DEVITO_LOGGING='DEBUG'
export DEVITO_ARCH='gcc'

export DEVITO_LANGUAGE=openmp
export DEVITO_LOGGING=DEBUG
export DEVITO_ARCH=gcc
cd /nfs
SINGULARITY_IMAGE=/nfs/devito.sif
if [[ ! -f $SINGULARITY_IMAGE ]]
then
    echo "Fetching the singularity image for Devito"
    curl -o $SINGULARITY_IMAGE --location "https://omnivector-public-assets.s3.us-west-2.amazonaws.com/singularity/devito.sif"
else
    echo "Skipping the image fetch process...we already have the singularity image"
fi
WORK_DIR=/nfs/$SLURM_JOB_NAME-Job-$SLURM_JOB_ID
mkdir -p $WORK_DIR
cd $WORK_DIR
echo "Downloading the the application source code"
APP=fwi.py
curl -o $APP --location "https://omnivector-public-assets.s3.us-west-2.amazonaws.com/code/fwi.py"
singularity exec --bind $PWD:$HOME $SINGULARITY_IMAGE python $APP
