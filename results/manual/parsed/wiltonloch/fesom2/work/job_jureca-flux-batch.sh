#!/bin/bash
#FLUX: --job-name=fesom2.0
#FLUX: -n=36
#FLUX: --queue=batch
#FLUX: -t=1800
#FLUX: --priority=16

module load CMake Intel IntelMPI imkl netCDF netCDF-Fortran
set -x
ulimit -s unlimited
JOBID=`echo $SLURM_JOB_ID |cut -d"." -f1`
ln -s ../bin/fesom.x .           # cp -n ../bin/fesom.x
cp -n ../config/namelist.config  .
cp -n ../config/namelist.forcing .
cp -n ../config/namelist.oce     .
cp -n ../config/namelist.ice     .
date
srun --mpi=pmi2 ./fesom.x > "fesom2.0.out"
date
