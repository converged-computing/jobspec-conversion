#!/bin/bash
#FLUX: --job-name=fugly-parrot-5102
#FLUX: --priority=16

pwd
module load slurm
spack load hpcc@develop fft=fftw3 %gcc ^armpl ^openmpi
EXE=${EXE:-$(which hpcc)}
echo $EXE
mpirun -n 48 $EXE 
