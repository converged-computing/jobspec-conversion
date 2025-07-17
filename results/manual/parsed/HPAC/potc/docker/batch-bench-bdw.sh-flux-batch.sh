#!/bin/bash
#FLUX: --job-name=bdw_potc_bench
#FLUX: --exclusive
#FLUX: --queue=c16m
#FLUX: -t=3600
#FLUX: --urgency=16

set -e
set -u
set -x
module load gcc/6
module switch intel intel/18.0
module switch openmpi intelmpi
base=$(mktemp -d -p $TEMP)
echo $base
mkdir $base/lammps
time cp -rp $PWD/nodocker/lammps-intel-bdw/src $base/lammps
mkdir $PWD/results/bdw/$SLURM_JOB_ID
lammps=$base/lammps potc=$PWD/.. tmp=$PWD/results/bdw/$SLURM_JOB_ID ./benchmark.sh test-intel.sh
rm -r $base
