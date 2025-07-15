#!/bin/bash
#FLUX: --job-name=p100_potc_bench
#FLUX: --exclusive
#FLUX: --queue=c16g
#FLUX: -t=3600
#FLUX: --priority=16

set -e
set -u
set -x
module switch intel gcc/6
module switch intelmpi openmpi
module load cuda
base=$(mktemp -d -p $TEMP)
echo $base
mkdir $base/lammps
time cp -rp $PWD/nodocker/lammps/src $base/lammps
mkdir $base/lammps/lib
time cp -rp $PWD/nodocker/lammps/lib/kokkos $base/lammps/lib
mkdir $PWD/results/p100/$SLURM_JOB_ID
lammps=$base/lammps potc=$PWD/.. tmp=$PWD/results/p100/$SLURM_JOB_ID ./benchmark.sh test-kokkos.sh
rm -r $base
