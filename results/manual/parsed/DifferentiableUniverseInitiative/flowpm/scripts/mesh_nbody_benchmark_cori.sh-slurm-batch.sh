#!/bin/bash
#SBATCH --account=m1759
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=10
#SBATCH --gpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=regular
#SBATCH --constraint=gpu,ntasks-per-node=4

export SLURM_CPU_BIND='cores'

module purge && module load cgpu esslurm tensorflow/2.4.1-gpu
export SLURM_CPU_BIND="cores"
srun python mesh_nbody_benchmark.py --nc=512 --batch_size=1 --nx=2 --ny=2 --hsize=32
