#!/bin/bash
#FLUX: --job-name="array_job"
#FLUX: --queue=shas
#FLUX: -t=300
#FLUX: --priority=16

export _OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MYSEED='$SLURM_JOB_ID'

module purge
module load matlab/R2017b
export _OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
cd $SLURM_SUBMIT_DIR
if [[ $SLURM_ARRAY_JOB_ID ]] ; then
	export JOB_ID=$SLURM_ARRAY_JOB_ID
	export SUB_ID=$SLURM_ARRAY_TASK_ID
else
	export JOB_ID=$SLURM_JOB_ID
	export SUB_ID=1
fi
mkdir -p $JOB_ID
cd $JOB_ID
mkdir -p $SUB_ID
cd $SUB_ID
cat $0 > myscript
printenv > env
export MYSEED=$SLURM_JOB_ID
cp $SLURM_SUBMIT_DIR/bunch.m .
	matlab -r bunch > bunch.out
	hostname > node
