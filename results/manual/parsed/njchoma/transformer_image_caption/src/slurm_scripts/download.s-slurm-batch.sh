#!/bin/bash
#SBATCH --job-name=download_annotations
#SBATCH --output=slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50GB
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=10

RUNDIR=$SCRATCH/imageCaptioning_run/dataset_check/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
cd $RUNDIR
wget http://msvocds.blob.core.windows.net/annotations-1-0-3/captions_train-val2014.zip -P $SCRATCH/COCO_features/data/
