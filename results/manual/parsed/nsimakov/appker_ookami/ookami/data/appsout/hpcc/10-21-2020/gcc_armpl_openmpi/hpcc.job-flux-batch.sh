#!/bin/bash
#FLUX --job-name=chocolate-motorcycle-4111
#FLUX --queue=long
#FLUX -t=86400
#FLUX --urgency=16

pwd
module load slurm
spack load hpcc@develop fft=fftw3 %gcc ^armpl ^openmpi
EXE=${EXE:-$(which hpcc)}
echo $EXE
mpirun -n 48 $EXE 
