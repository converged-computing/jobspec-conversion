#!/bin/bash
#FLUX: --job-name=netflix
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load python3/intel/3.6.3
module load cuda/9.2.88
module load tensorflow/python3.6/1.5.0
COREDIR=$SCRATCH/netflix/core/
LOCALPY=$SCRATCH/netflix/bin/python3.6
RUNDIR=$SCRATCH/netflix-runs/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
cp -r $COREDIR/* $RUNDIR/.
OUTDIR=$RUNDIR/results
$LOCALPY $RUNDIR/main.py
