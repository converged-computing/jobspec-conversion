#!/bin/bash
#SBATCH --job-name=array_job
#SBATCH --output=/dev/null
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=00:05:00
#SBATCH --partition=shas
#SBATCH --constraint=ntasks-per-node=1

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
