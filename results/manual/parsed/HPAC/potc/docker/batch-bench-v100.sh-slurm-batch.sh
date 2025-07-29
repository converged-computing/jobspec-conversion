#!/bin/bash
#SBATCH --job-name=v100_potc_bench
#SBATCH --account=nova0013
#SBATCH --output=results/v100/log-%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:2
#SBATCH --mem=1024M
#SBATCH --time=01:00:00
#SBATCH --exclusive

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
mkdir $PWD/results/v100/$SLURM_JOB_ID
lammps=$base/lammps potc=$PWD/.. tmp=$PWD/results/v100/$SLURM_JOB_ID gpu_arch=Volta70 ./benchmark.sh test-kokkos.sh
rm -r $base
