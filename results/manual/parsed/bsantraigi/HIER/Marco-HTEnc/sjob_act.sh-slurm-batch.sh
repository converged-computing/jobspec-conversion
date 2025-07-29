#!/bin/bash
#FLUX: --job-name=HIER_marcoAct
#FLUX: --queue=gpu
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

pwd; hostname; date
module load compiler/intel-mpi/mpi-2019-v5
module load compiler/cuda/10.1
export CUDA_VISIBLE_DEVICES=0
nvidia-smi
mpirun -bootstrap slurm which python
mpirun -bootstrap slurm nvcc --version
mpirun -bootstrap slurm python train_generator.py --option train --model modelAct/ --batch_size 512 --max_seq_length 50 --act_source pred --learning_rate 1e-4 --nlayers_e 3 --nlayers_d 3 --seed 0
