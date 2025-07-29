#!/bin/bash
#SBATCH --job-name=bdw_potc_bench
#SBATCH --output=results/bdw/log-%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1024M
#SBATCH --time=01:00:00
#SBATCH --exclusive

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
