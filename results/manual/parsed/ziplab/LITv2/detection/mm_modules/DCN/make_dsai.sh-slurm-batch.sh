#!/bin/bash
#SBATCH --account=hhe
#SBATCH --mail-user=zizhengpan98@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --mem=64GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=node04

module load cuda-11.2.0-gcc-10.2.0-gsjevs3
source activate torch171
nvidia-smi
nvcc -V
python setup.py build install
