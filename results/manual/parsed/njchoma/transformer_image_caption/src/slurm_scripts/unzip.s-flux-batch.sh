#!/bin/bash
#FLUX: --job-name=unzip_features
#FLUX: -t=36000
#FLUX: --urgency=16

RUNDIR=$SCRATCH/imageCaptioning_run/dataset_check/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
cd $RUNDIR
unzip $SCRATCH/COCO_features/data/trainval_36.zip
