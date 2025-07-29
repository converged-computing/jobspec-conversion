#!/bin/bash
#SBATCH --job-name=sGW
#SBATCH --account=<your-account>
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=1
#SBATCH --time=00:29:59
#SBATCH --qos=debug
#SBATCH --constraint=gpu,ntasks-per-node=4

export SLURM_CPU_BIND='cores'

module swap PrgEnv-gnu PrgEnv-nvidia
module load cray-fftw
export SLURM_CPU_BIND="cores"
srun sgw_gpu.x
