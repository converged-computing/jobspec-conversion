#!/bin/bash
#FLUX: --job-name=array_job
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_NUM_THREADS='2'
export EXE='invertp.py'

module purge
module load   gcc/7.3.0   comp-intel/2018.0.3 intel-mpi/2018.0.3 mkl/2018.3.222
export OMP_NUM_THREADS=1
export OMP_NUM_THREADS=2
export EXE=invertp.py
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
if [ -z ${LIST+x} ]; then echo "LIST is unset"; export LIST=list ; else echo "LIST is set to '$LIST'"; fi
	dir=`head -n $SUB_ID $SLURM_SUBMIT_DIR/$LIST | tail -1`
	cp -r $SLURM_SUBMIT_DIR/inputs/$dir/* .
	printenv > envs
	$SLURM_SUBMIT_DIR/tymer timer start_time
	$SLURM_SUBMIT_DIR/$EXE `cat myinput` > output
	hostname > node
	echo $SLURM_SUBMIT_DIR/inputs/$dir > directory
	$SLURM_SUBMIT_DIR/tymer timer end_time
