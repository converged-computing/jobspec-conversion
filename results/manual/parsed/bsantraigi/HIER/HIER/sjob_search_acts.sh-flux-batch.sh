#!/bin/bash
#FLUX: --job-name=lovable-squidward-1116
#FLUX: -t=172800
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1'

module load compiler/intel-mpi/mpi-2019-v5
module load compiler/cuda/10.1
export CUDA_VISIBLE_DEVICES=0,1
nvidia-smi
mpirun -bootstrap slurm which python
mpirun -bootstrap slurm nvcc --version
mpirun -bootstrap slurm python search_params_acts.py -e 5 -model HIER++
