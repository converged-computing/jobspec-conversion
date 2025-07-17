#!/bin/bash
#FLUX: --job-name=hpcggpu
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

module reset
module load gpu
module load slurm
module load cuda
module load openmpi
mpirun -np 2 ./xhpcg-3.1_cuda-11_ompi-4.0_sm_60_sm70_sm80 
