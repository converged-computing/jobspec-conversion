#!/bin/bash
#SBATCH --job-name=pytorch-ngc
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:02:00

module purge
singularity exec --nv $HOME/software/pytorch_23.09-py3.sif python3 mnist_classify.py --epochs=3
