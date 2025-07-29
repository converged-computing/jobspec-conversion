#!/bin/bash
#SBATCH --job-name=fesom2.0
#SBATCH --output=slurm-out.out
#SBATCH --error=slurm-err.out
#SBATCH --nodes=1
#SBATCH --ntasks=288
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=batch

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
