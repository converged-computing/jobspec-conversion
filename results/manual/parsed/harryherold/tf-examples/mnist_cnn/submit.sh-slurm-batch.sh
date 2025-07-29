#!/bin/bash
#SBATCH --job-name=MNIST_CNN_EPOCHS
#SBATCH --account=p_hpdlf_itwm
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=00:30:00
#SBATCH --exclusive

module load modenv/ml
module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
cd /home/cherold/workspace/python/tf-examples/mnist_cnn
./measure_epochs.sh
