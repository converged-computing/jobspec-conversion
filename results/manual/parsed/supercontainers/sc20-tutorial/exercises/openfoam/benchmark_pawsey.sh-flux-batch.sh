#!/bin/bash
#FLUX: --job-name=mpi
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -t=1200
#FLUX: --priority=16

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
