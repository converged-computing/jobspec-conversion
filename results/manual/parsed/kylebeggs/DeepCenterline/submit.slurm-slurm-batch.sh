#!/bin/bash
#SBATCH --mail-user=kbeggs07@knights.ucf.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00

module load anaconda/anaconda3
module list
source activate torch-medical
nvidia-smi
nvidia-smi topo -m
cd src
python train.py --name pooling --model pooling --epochs 20 --lr 0.01
