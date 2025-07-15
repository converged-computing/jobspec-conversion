#!/bin/bash
#FLUX: --job-name=gassy-pot-9501
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

pwd; hostname; date
module load compiler/intel-mpi/mpi-2019-v5
module load compiler/cuda/10.1
source /home/$USER/.bashrc
export CUDA_VISIBLE_DEVICES=0
nvidia-smi
mpirun -bootstrap slurm which python
mpirun -bootstrap slurm nvcc --version
mpirun -bootstrap slurm python -u train_generator.py --option train --model model/ --batch_size 384 --max_seq_length 50 --act_source bert --learning_rate 1e-4 --nlayers_e 6 --nlayers_d 3 --seed 0
