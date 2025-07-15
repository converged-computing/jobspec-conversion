#!/bin/bash
#FLUX: --job-name="invert"
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module purge
module load matlab/R2017b
cd $SLURM_SUBMIT_DIR
mkdir $SLURM_JOBID
cd $SLURM_JOBID
cp ../hpc*m .
cp ../do_invert .
cp ../randRA.cpp .
mex randRA.cpp
cat $0 > script.$SLURM_JOBID
printenv  > env.$SLURM_JOBID
$SLURM_SUBMIT_DIR/tymer clock "starting the job"
./do_invert > $SLURM_JOB_ID.out
$SLURM_SUBMIT_DIR/tymer clock "job has finished"
cp ../slurm-$SLURM_JOB_ID* .
