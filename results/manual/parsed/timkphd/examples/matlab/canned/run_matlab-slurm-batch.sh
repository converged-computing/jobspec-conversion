#!/bin/bash
#SBATCH --job-name=invert
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=8

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
