#!/bin/bash
#SBATCH --job-name=mpi
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=1

image="docker://pawsey/mpich-base:3.1.4_ubuntu18.04"
osu_dir="/usr/local/libexec/osu-micro-benchmarks/mpi"
module unload xalt
module load singularity
echo $SINGULARITYENV_LD_LIBRARY_PATH
srun singularity exec $image \
  $osu_dir/pt2pt/osu_bw -m 1024:1048576
unset SINGULARITYENV_LD_LIBRARY_PATH
srun singularity exec $image \
  $osu_dir/pt2pt/osu_bw -m 1024:1048576
