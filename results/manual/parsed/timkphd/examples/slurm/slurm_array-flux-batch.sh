#!/bin/bash
#FLUX: --job-name="array_job"
#FLUX: -t=172800
#FLUX: --priority=16

export LD_LIBRARY_PATH='/opt/lib/extras:$LD_LIBRARY_PATH'
export ARGS='`date`'
export dir='mysub_$SUB_ID'

export LD_LIBRARY_PATH=/opt/lib/extras:$LD_LIBRARY_PATH
cd $SLURM_SUBMIT_DIR
if [[ $SLURM_ARRAY_JOB_ID ]] ; then
	JOB_ID=$SLURM_ARRAY_JOB_ID
	SUB_ID=$SLURM_ARRAY_TASK_ID
else
	JOB_ID=$SLURM_JOB_ID
	SUB_ID=1
fi
if [ -e pars ] ; then
export ARGS=`head -n $SUB_ID pars | tail -1`
else
export ARGS=`date`
fi
if [ -e list ] ; then
export dir=`head -n $SUB_ID list | tail -1`
else
export dir=mysub_$SUB_ID
fi
mkdir -p $dir
cd $dir
srun -n 1 $SLURM_SUBMIT_DIR/p_array $ARGS > out.dat
