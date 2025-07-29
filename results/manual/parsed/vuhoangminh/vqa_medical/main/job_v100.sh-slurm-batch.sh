#!/bin/bash
#SBATCH --account=SNIC2018-3-406
#SBATCH --output=%J_output.out
#SBATCH --error=%J_error.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --time=7-00:00:00

export PYTHONPATH='${PWD}:$PYTHONPATH'
export KERAS_BACKEND='tensorflow'
export command='python main/loop_train_v100.py'

ml GCC/6.4.0-2.28  CUDA/9.0.176  OpenMPI/2.1.1
export PYTHONPATH=${PWD}:$PYTHONPATH
export KERAS_BACKEND="tensorflow"
export command="python main/loop_train_v100.py"
echo "$command"
srun $command
wait
