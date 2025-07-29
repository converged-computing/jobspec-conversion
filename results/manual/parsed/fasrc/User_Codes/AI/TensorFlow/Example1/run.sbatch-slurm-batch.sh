#!/bin/bash
#SBATCH --job-name=dnn
#SBATCH --output=tf_mnist.out
#SBATCH --error=tf_mnist.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=00:03:00

module load python/3.10.9-fasrc01
source activate tf2.12_cuda11
srun -n 1 --gres=gpu:1 python tf_mnist.py
