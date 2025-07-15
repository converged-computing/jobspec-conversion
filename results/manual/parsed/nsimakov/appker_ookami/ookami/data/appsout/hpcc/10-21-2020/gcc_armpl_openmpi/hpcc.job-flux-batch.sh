#!/bin/bash
#FLUX: --job-name=arid-bicycle-7337
#FLUX: --urgency=16

pwd
module load slurm
spack load hpcc@develop fft=fftw3 %gcc ^armpl ^openmpi
EXE=${EXE:-$(which hpcc)}
echo $EXE
mpirun -n 48 $EXE 
