#!/bin/bash
#FLUX: --job-name=gloopy-snack-0789
#FLUX: --priority=16

pwd
module restore PrgEnv-cray
module load cray-mvapich2_nogpu_svealpha
module load cray-fftw 
module load slurm
spack load hpcc@develop fft=fftw3 %cce ^mvapich2 ^cray-libsci
EXE=${EXE:-$(which hpcc)}
srun $EXE 
