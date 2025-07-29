#!/bin/bash
#SBATCH --account=sc3260
#SBATCH --output=alexnet_multiple_gpu.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=20:00:00

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python tf_cnn_benchmarks.py --num_gpus=1 --batch_size=32 --model=alexnet --variable_update=parameter_server
