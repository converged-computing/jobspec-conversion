#!/bin/bash
#FLUX: --job-name=weak-scalability
#FLUX: -t=3600
#FLUX: --urgency=16

HOME_MURPHY=/home/ucl/tfl/tgillis/murphy
SCRATCH=$GLOBALSCRATCH
RUN_DIR=murphy_weak_${SLURM_JOB_NUM_NODES}_${SLURM_JOB_ID}
mkdir -p $SCRATCH/$RUN_DIR
mkdir -p $SCRATCH/$RUN_DIR/data
mkdir -p $SCRATCH/$RUN_DIR/prof
cp -r $HOME_MURPHY/murphy $SCRATCH/$RUN_DIR
cd $SCRATCH/$RUN_DIR 
mpirun ./murphy --abc --profile --iter-max=1000 --iter-dump=10 --dump-detail=0 --rtol=1e-2 --ctol=1e-4 --vr-sigma=0.025 --dom=1,1,$SLURM_JOB_NUM_NODES > log_$SLURM_JOB_ID.log
