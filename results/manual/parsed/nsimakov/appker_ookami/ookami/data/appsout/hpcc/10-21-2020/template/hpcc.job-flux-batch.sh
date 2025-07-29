#!/bin/bash
#FLUX --job-name=nerdy-milkshake-1721
#FLUX --queue=long
#FLUX -t=86400
#FLUX --urgency=16

pwd
module restore PrgEnv-cray
module load cray-mvapich2_nogpu_svealpha
module load cray-fftw 
module load slurm
spack load hpcc@develop fft=fftw3 %cce ^mvapich2 ^cray-libsci
EXE=${EXE:-$(which hpcc)}
srun $EXE 
