#!/bin/bash

#SBATCH --job-name=cmxe-depth
#SBATCH --output=slurm_combinedmxe_depth_experiments.out
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32GB
#SBATCH --time=7-00:00:00
#SBATCH --gres=gpu:1

# Modules
module purge
module load jupyter-kernels/py2.7
module load scikit-learn/intel/0.18.1
module load theano/0.9.0
module load tensorflow/python2.7/20170707
module load keras/2.0.2

cd /home/jb6504/higgs_inference/higgs_inference

#python -u experiments.py combinedmxe -o shallow
#python -u experiments.py combinedmxe --training random -o shallow

python -u experiments.py combinedmxe
python -u experiments.py combinedmxe --training random
