#!/bin/bash
#FLUX: --job-name=wobbly-parrot-5217
#FLUX: -c=6
#FLUX: -t=64800
#FLUX: --priority=16

export JULIA_NUM_THREADS='$SLURM_CPUS_PER_TASK'

set -euo pipefail
export JULIA_NUM_THREADS=$SLURM_CPUS_PER_TASK
NOW=$(date +"%m_%d_%Y_HH%I_%M")
echo "Starting setup at $NOW"
cp "<location_of_image.sif>" "$SLURM_TMPDIR/mcsdetect.sif"
echo "Starting task $SLURM_ARRAY_TASK_ID"
IDIR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" inlist.txt)
ODIR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" outlist.txt)
IMAGE="$SLURM_TMPDIR/mcsdetect.sif"
LSRC="/opt/SubPrecisionContactDetection.jl"
mkdir -p $ODIR
for ALPHA in 0.001 0.01 0.025 0.05
do
    echo "Starting with alpha $ALPHA"
    mkdir -p $ODIR/$ALPHA
    NOW=$(date +"%m_%d_%Y_HH%I_%M")
    singularity exec $IMAGE julia --project=$LSRC --sysimage=$LSRC/sys_img.so $LSRC/src/ercontacts.jl  --inpath $IDIR -r "*[1,2].tif" -w 2 --deconvolved --sigmas 2.5-2.5-1.5 --outpath  $ODIR/$ALPHA --alpha $ALPHA --beta  $ALPHA -c 1 -v 2000 --mode=decon 2>&1 | tee -a log_$NOW.txt
done
NOW=$(date +"%m_%d_%Y_HH%I_%M")
echo "DONE at ${NOW}"
