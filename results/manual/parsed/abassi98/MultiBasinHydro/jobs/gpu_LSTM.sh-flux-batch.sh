#!/bin/bash
#FLUX: --job-name=gpu_LSTM-bdTrueStat
#FLUX: -c=24
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load daint-gpu PyTorch      
python3 ../src/LSTM_main.py --noise_dim 0 --statics 1 --bidirectional 1 --debug 0 # no noise, static features addes, bidirectional, training mode
