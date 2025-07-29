#!/bin/bash
#SBATCH --job-name=gpu_LSTM-bdTrueStat
#SBATCH --account=em09
#SBATCH --output=gpu_LSTM-bdTrueStat.out
#SBATCH --error=gpu_LSTM-bdTrueStat.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load daint-gpu PyTorch      
python3 ../src/LSTM_main.py --noise_dim 0 --statics 1 --bidirectional 1 --debug 0 # no noise, static features addes, bidirectional, training mode
