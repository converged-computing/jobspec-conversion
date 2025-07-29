#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=2

SINGULARITYENV_LD_LIBRARY_PATH=/opt/openmpi/lib
SINGULARITYENV_PREPEND_PATH=/opt/openmpi/bin
mpiexec -n 4 singularity exec -B /opt/openmpi ~/centos7.sif ~/mpitest
echo $?
