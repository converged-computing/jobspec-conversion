#!/bin/bash
#FLUX: --job-name=frigid-pot-1348
#FLUX: --priority=16

module unload gnu_comp
module load intel_comp/2019
module load intel_mpi/2019
module load fftw/2.1.5 
module load gsl/2.4
module load hdf5 #/1.8.20 
set -x
rm -f out/*
mpirun -np $SLURM_NTASKS /cosma/home/durham/dc-boru1/Gadget-RAPHAMW/source/Gadget2 params.txt > log.out
julia calc_peris.jl
