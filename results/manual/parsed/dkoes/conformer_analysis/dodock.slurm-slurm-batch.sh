#!/bin/bash
#SBATCH --job-name=dock
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2

export PATH='/net/pulsar/home/koes/dkoes/git/smina/build/:$PATH'

export PATH=/net/pulsar/home/koes/dkoes/git/smina/build/:$PATH
cd $SLURM_SUBMIT_DIR
cmd=`sed -n "${SLURM_ARRAY_TASK_ID}p" alldock`
eval $cmd
