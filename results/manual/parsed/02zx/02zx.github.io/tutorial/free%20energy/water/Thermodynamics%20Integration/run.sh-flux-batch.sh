#!/bin/bash
#FLUX: --job-name=liquid
#FLUX: -n=16
#FLUX: --queue=NVIDIAGeForceRTX4090
#FLUX: --urgency=16

module load compiler/gcc/7.3.1
module load compiler/intel/2021.3.0
module load mpi/intelmpi/2021.3.0
module swap apps/gromacs/intelmpi/2021.7-4090
module load mathlib/fftw/intelmpi/3.3.9_single
i=395
gmx_mpi mdrun -ntomp 16 -v -pin on -deffnm ./$i/md -gpu_id 0 -pme gpu -nb gpu
