#!/bin/bash
#SBATCH --account=training2203
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:4
#SBATCH --time=02:00:00

module load Stages/2022 GCC/11.2.0 OpenMPI/4.1.2 Horovod/0.24.2-Python-3.9.6 Nsight-Systems
cd /p/home/jusers/$USER/juwels/projects/makers
srun python fbsde.py --n_paths=262144
