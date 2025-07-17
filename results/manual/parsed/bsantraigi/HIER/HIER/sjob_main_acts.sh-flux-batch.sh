#!/bin/bash
#FLUX: --job-name=main_best_hier
#FLUX: --queue=gpu
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1'

pwd; hostname; date
module load compiler/intel-mpi/mpi-2019-v5
module load compiler/cuda/10.1
export CUDA_VISIBLE_DEVICES=0,1
mpirun -bootstrap slurm which python
mpirun -bootstrap slurm nvcc --version
mpirun -bootstrap slurm python main_acts.py -embed 175 -heads 7 -hid 91 -l_e1 4 -l_e2 6 -l_d 3 -d 0.071 -bs 16 -e 60 -model HIER++
