#!/bin/bash
#FLUX: --job-name=doopy-milkshake-2945
#FLUX: --priority=16

module load intel/18.0.2 cmake/3.7.1 gsl boost hdf5 eigen impi python3
source ../prepare_compilation_stampede2_2.sh
module list
inputdir=../input-config
job=$SLURM_JOB_ID
ntasks=1
srun run-events --nevents 1 --rankvar SLURM_PROCID --rankfmt "{:0${#ntasks}d}" --logfile $SCRATCH/$job.log --tmpdir=$SCRATCH/ --startdir=$inputdir $job.dat
