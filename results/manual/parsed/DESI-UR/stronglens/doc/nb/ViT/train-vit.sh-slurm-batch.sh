#!/bin/bash
#SBATCH --job-name=stronglens-vit-training
#SBATCH --account=desi_g
#SBATCH --output=train-vit.log
#SBATCH --mail-user=dcummin4@u.rochester.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=09:00:00
#SBATCH --constraint=gpu

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load pytorch/1.13.1
srun -n 1 -c 128 --cpu_bind=cores -G 1 --gpu-bind=single:1 python /pscratch/sd/d/dcummins/vit/Training.py
