#!/bin/bash
#SBATCH --job-name=pytorch_mnist
#SBATCH --output=pytorch_mnist%j.out
#SBATCH --error=pytorch_mnist%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1

set -x
cd $WORK/jean-zay-doc/examples/pytorch
module purge
module load pytorch-gpu/py3/1.4.0 
python ./mnist_example.py 
