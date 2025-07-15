#!/bin/bash
#FLUX: --job-name=moolicious-bike-8329
#FLUX: -N=16
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: -t=43200
#FLUX: --priority=16

set -e
module purge
module load $(spack module find mpich +pmi)
module load $(spack module find hdf5 -fortran -mpi)
module load $(spack module find gsl)
module load $(spack module find metis)
cd /home/mdavezac/swift/swift_16_1
cp /home/mdavezac/swift/eagle_25.yml  .
[ ! -e /home/mdavezac/swift/swift_16_1/EAGLE_ICs_25.hdf5 ] && ln -s /home/mdavezac/swift/EAGLE_ICs_25.hdf5 .
time mpirun /home/mdavezac/swift/usr/bin/swift_mpi -s -a -t 16 -n 4096 eagle_25.yml
