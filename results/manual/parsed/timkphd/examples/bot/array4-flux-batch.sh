#!/bin/bash
#FLUX: --job-name="array_job"
#FLUX: -t=172800
#FLUX: --priority=16

export FLIST='list'
export DOPRINT='yes'

module purge
module load StdEnv
module load PrgEnv/python/gcc/2.7.11
cd $SLURM_SUBMIT_DIR
if [[ $SLURM_ARRAY_JOB_ID ]] ; then
	JOB_ID=$SLURM_ARRAY_JOB_ID
	SUB_ID=$SLURM_ARRAY_TASK_ID
else
	JOB_ID=$SLURM_JOB_ID
	SUB_ID=0
fi
export FLIST=list
export DOPRINT=yes
mkdir -p $SLURM_ARRAY_JOB_ID
cd $SLURM_ARRAY_JOB_ID
cmd=`echo $SLURM_ARRAY_TASK_ID"q;d"`
aline=`sed -e $cmd $SLURM_SUBMIT_DIR/pars`
cl=`echo $aline | awk '{print("-v x " $1 " -v y " $2 " -v z " $3)}'`
dir=`echo $aline | awk '{print($1"/"$2"/"$3)}'`
echo "SLURM_ARRAY_TASK_ID=" $SLURM_ARRAY_TASK_ID "CL=" $cl "DIR=" $dir
mkdir -p $dir
cd $dir
srun -n 2 $SLURM_SUBMIT_DIR/p_array $cl > out.dat
wait
