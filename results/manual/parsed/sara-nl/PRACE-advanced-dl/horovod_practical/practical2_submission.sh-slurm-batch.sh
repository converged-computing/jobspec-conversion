#!/bin/bash
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:50:00
#SBATCH --partition=broadwell

ulimit -a
module load Python/3.6.3-foss-2017b
source hdis/bin/activate
mpirun -np 16 --map-by ppr:1:socket:pe=16 python keras-cifar10-resnet.py
