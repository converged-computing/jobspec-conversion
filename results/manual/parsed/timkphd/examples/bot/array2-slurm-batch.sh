#!/bin/bash
#SBATCH --job-name=array_job
#SBATCH --output=outz-%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=2

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
for x in `cat $FLIST` ; do mkdir -p $x ; done
srun -n 2 ./dummy
wait
