#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=0
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=2

module load gcc/8.4.0-cuda
module load mvapich2/2.3.4
module load py-torch/1.6.0-cuda-openmp
module load py-h5py/2.10.0-mpi
module load py-mpi4py/3.0.3
source /home/coppey/venvs/venv_lcd/bin/activate
srun python train.py
