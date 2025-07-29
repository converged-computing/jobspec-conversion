#!/bin/bash
#SBATCH --job-name=mnist_2GPUs
#SBATCH --output=mnist_batch_%j.log
#SBATCH --mail-user=email@ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=a100:2
#SBATCH --mem=64gb
#SBATCH --time=00:30:00
#SBATCH --partition=gpu

pwd; hostname; date           # Print some useful info
module load tensorflow/2.7.0        # Be sure to load the tensorflow module
echo "Running mnist script"
python distributed_mnist.py  # Run the script
date
