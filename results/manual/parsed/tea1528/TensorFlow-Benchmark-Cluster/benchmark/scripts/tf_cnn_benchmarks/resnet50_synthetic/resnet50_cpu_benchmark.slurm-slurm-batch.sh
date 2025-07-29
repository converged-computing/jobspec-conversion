#!/bin/bash
#SBATCH --account=sc3260
#SBATCH --output=cpu.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=20:00:00

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest \
    python tf_cnn_benchmarks.py --batch_size=32 --model=resnet50 --variable_update=parameter_server --device=cpu --data_format=NHWC
