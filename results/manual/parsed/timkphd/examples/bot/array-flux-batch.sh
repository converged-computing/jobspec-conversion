#!/bin/bash
#FLUX: --job-name="array_job"
#FLUX: -t=120
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module purge
module load StdEnv
module load PrgEnv/python/gcc/2.7.11
if [[ $SLURM_ARRAY_JOB_ID ]] ; then
	JOB_ID=$SLURM_ARRAY_JOB_ID
	SUB_ID=$SLURM_ARRAY_TASK_ID
else
	JOB_ID=$SLURM_JOB_ID
	SUB_ID=0
	SLURM_ARRAY_TASK_MAX=-1
	SLURM_ARRAY_TASK_MIN=-2
fi
mkdir -p $JOB_ID/$SUB_ID
cd $JOB_ID/$SUB_ID
srun $SLURM_SUBMIT_DIR/p_array $SLURM_ARRAY_TASK_MAX $SLURM_ARRAY_TASK_MIN > with_p.$SUB_ID  2>&1 
srun $SLURM_SUBMIT_DIR/c_array $SLURM_ARRAY_TASK_MAX $SLURM_ARRAY_TASK_MIN > with_c.$SUB_ID  2>&1 
srun $SLURM_SUBMIT_DIR/f_array $SLURM_ARRAY_TASK_MAX $SLURM_ARRAY_TASK_MIN > with_f.$SUB_ID  2>&1 
