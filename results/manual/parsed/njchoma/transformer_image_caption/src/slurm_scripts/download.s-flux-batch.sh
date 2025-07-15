#!/bin/bash
#FLUX: --job-name=download_annotations
#FLUX: -t=36000
#FLUX: --priority=16

RUNDIR=$SCRATCH/imageCaptioning_run/dataset_check/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
cd $RUNDIR
wget http://msvocds.blob.core.windows.net/annotations-1-0-3/captions_train-val2014.zip -P $SCRATCH/COCO_features/data/
