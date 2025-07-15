#!/bin/bash
#FLUX: --job-name=mpi-test
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --priority=16

if [ -n $SLURM_JOB_ID ];  then
    # check the original location through scontrol and $SLURM_JOB_ID
    SCRIPT_PATH=$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
else
    # otherwise: started with bash. Get the real location.
    SCRIPT_PATH=$(realpath $0)
fi
REPO_PATH=$(dirname "${SCRIPT_PATH}")
module load mpich/gcc
RMAT_SCALE=22
echo ""
echo " About to run the mpi job"
echo ""
srun --mpi=pmix ./build/mpitc -iftype=rmat -scale=${RMAT_SCALE} -dbglvl=1
