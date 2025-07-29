#!/bin/bash
#SBATCH --job-name=tensorflow_tutorial
#SBATCH --mail-user=YourNetID@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1

module load anaconda3
source activate tf-gpu
srun python mnist_classify.py
