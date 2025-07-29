#!/bin/bash
#FLUX: --job-name=array_job
#FLUX: --exclusive
#FLUX: --queue=debug
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_NUM_THREADS='2'
export EXE='invertp.py'

module purge
module load slurm
module use /projects/hpcapps/tkaiser2/011923_b/lmod/linux-rocky8-x86_64/gcc/12.1.0/
module load python/3.11.1
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
    export input=`head -n $SUB_ID $SLURM_SUBMIT_DIR/$LIST | tail -1`
    printenv > envs
	$SLURM_SUBMIT_DIR/tymer timer start_time
	echo $input > input
	eval $SLURM_SUBMIT_DIR/$EXE `cat input` > output
	hostname > node
	$SLURM_SUBMIT_DIR/tymer timer end_time
