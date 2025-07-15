#!/bin/bash
#FLUX: --job-name=fuzzy-chip-4999
#FLUX: -c=6
#FLUX: -t=64800
#FLUX: --urgency=16

export JULIA_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export SINGULARITY_BINDPATH='/scratch/$USER,$SLURM_TMPDIR'

set -euo pipefail
export JULIA_NUM_THREADS=$SLURM_CPUS_PER_TASK
NOW=$(date +"%m_%d_%Y_HH%I_%M")
echo "Starting setup at $NOW"
cp mcsdetect.sif $SLURM_TMPDIR/mcsdetect.sif
IDIR=INPUT
ODIR=POSTOUTPUT
IMAGE="$SLURM_TMPDIR/mcsdetect.sif"
LSRC="/opt/SubPrecisionContactDetection.jl"
module load singularity
export SINGULARITY_BINDPATH="/scratch/$USER,$SLURM_TMPDIR"
singularity exec $IMAGE julia --project=$LSRC --sysimage=$LSRC/sys_img.so $LSRC/scripts/run_cube_sampling_on_dataset.jl  --inpath $IDIR --outpath  $ODIR 2>&1 | tee -a log_$NOW.txt
NOW=$(date +"%m_%d_%Y_HH%I_%M")
echo "DONE at ${NOW}"
