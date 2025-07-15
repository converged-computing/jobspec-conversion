#!/bin/bash
#FLUX: --job-name=openMP
#FLUX: -t=600
#FLUX: --urgency=16

module load GCC/6.4.0-2.28 OpenMPI  ### load necessary modules.
module load cuDNN/8.4.1.50-CUDA-11.6.0
module load NCCL/2.8.3-CUDA-11.1.1 
cd /mnt/home/gaudisac/pGPT/        ### change to the directory where your code is located.
srun -n 1 ./hello.o     ### call your executable. (use srun instead of mpirun.)
scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
