#!/bin/bash
#SBATCH --job-name=tf_test
#SBATCH --account=interns2017
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00
#SBATCH --partition=gpuq
#SBATCH --constraint=ntasks-per-node=1,p100

module load gcc/5.4.0 broadwell
module load tensorflow
srun --export=ALL python tf_cnn_benchmarks/tf_cnn_benchmarks.py --num_gpus=4 --batch_size=64 --model=resnet50 --variable_update=parameter_server
