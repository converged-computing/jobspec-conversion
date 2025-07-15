#!/bin/bash
#FLUX: --job-name=strawberry-lemon-3523
#FLUX: --urgency=16

pwd
module restore PrgEnv-cray
module load cray-mvapich2_nogpu_svealpha
module load slurm
spack load hpcc@develop fft=internal %cce ^mvapich2 ^cray-libsci
EXE=${EXE:-$(which hpcc)}
srun $EXE 
