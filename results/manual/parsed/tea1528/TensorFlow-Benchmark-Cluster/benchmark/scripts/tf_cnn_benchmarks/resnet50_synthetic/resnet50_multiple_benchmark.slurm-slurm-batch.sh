#!/bin/bash
#SBATCH --account=sc3260
#SBATCH --output=multiple_gpu.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:3
#SBATCH --mem=10G
#SBATCH --time=20:00:00

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python tf_cnn_benchmarks.py --num_gpus=3 --batch_size=32 --model=resnet50 --variable_update=parameter_server
