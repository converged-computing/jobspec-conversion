#!/bin/bash
#FLUX: --job-name=lovable-arm-8667
#FLUX: -N=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load gcc/8.4.0-cuda
module load mvapich2/2.3.4
module load py-torch/1.6.0-cuda-openmp
module load py-h5py/2.10.0-mpi
module load py-mpi4py/3.0.3
source /home/coppey/venvs/venv_lcd/bin/activate
srun python train.py
