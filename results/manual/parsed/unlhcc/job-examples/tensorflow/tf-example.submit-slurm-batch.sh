#!/bin/bash
#SBATCH --job-name=tensorflow_gpu_example
#SBATCH --output=tf_job.%J.out
#SBATCH --error=tf_job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem-per-cpu=4g
#SBATCH --time=00:15:00

module purge
module load tensorflow-gpu/py39/2.9
python tf_hello.py
