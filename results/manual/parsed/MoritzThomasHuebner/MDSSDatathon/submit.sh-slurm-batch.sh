#!/bin/bash
#SBATCH --job-name=Train_Py
#SBATCH --output=log.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1000
#SBATCH --time=01:00:00
#SBATCH --partition=skylake
#SBATCH --constraint=ntasks-per-node=1

module load python
module load numpy/1.14.1-python-2.7.14
module load tensorflowgpu/1.6.0-python-2.7.14
module load scikit-learn/0.19.1-python-2.7.14
module load keras/2.1.4-python-2.7.14
module load h5py/2.7.1-python-2.7.14-serial
python train.py
