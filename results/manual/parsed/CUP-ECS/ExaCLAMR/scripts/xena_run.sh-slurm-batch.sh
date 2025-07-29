#!/bin/bash
#FLUX: --job-name=ExaCLAMR
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load gcc/8.3.0-wbma
module load openmpi/4.0.5-cuda-rla7
module load cmake
module load cuda/11.2.0-qj6z
mkdir -p data
mkdir -p data/raw
rm -rf data/raw/*
srun -N 2 -n 2 ./build/examples/DamBreak -mcuda -n1000 -t100 -w10
