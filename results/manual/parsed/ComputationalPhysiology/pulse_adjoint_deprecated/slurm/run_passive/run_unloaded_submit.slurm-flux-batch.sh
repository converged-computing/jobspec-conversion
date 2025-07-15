#!/bin/bash
#FLUX: --job-name=UnloadedImpact
#FLUX: -t=345600
#FLUX: --urgency=16

export CC='gcc'
export CXX='g++'
export FC='gfortran'
export F77='gfortran'
export F90='gfortran'

mkdir -p slurmfiles
source /cluster/bin/jobsetup
set -o errexit # exit on errors
module purge   # clear any inherited modules
module load gcc/5.1.0
module load openmpi.gnu/1.8.8
module load cmake/3.1.0
export CC=gcc
export CXX=g++
export FC=gfortran
export F77=gfortran
export F90=gfortran
ulimit -S -s unlimited
arrayrun $1-$2 run_unloaded.slurm
