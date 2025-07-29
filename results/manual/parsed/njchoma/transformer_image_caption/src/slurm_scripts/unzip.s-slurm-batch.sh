#!/bin/bash
#SBATCH --job-name=unzip_features
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
unzip $SCRATCH/COCO_features/data/trainval_36.zip
