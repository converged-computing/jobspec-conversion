#!/bin/bash
#FLUX: --job-name=skx_potc_bench
#FLUX: --exclusive
#FLUX: --queue=c18m
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
time cp -rp $PWD/nodocker/lammps-intel-skx/src $base/lammps
mkdir $PWD/results/skx-rebo/$SLURM_JOB_ID
lammps=$base/lammps potc=$PWD/.. tmp=$PWD/results/skx-rebo/$SLURM_JOB_ID ./benchmark.sh test-intel-rebo-regular.sh
rm -r $base
