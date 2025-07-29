#!/bin/bash
#SBATCH --job-name=sGW
#SBATCH --account=<your-account>
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=2
#SBATCH --time=00:29:59
#SBATCH --qos=debug
#SBATCH --constraint=cpu,ntasks-per-node=128

export SLURM_CPU_BIND='cores'

module swap PrgEnv-nvidia PrgEnv-gnu
module load cray-fftw
export SLURM_CPU_BIND="cores"
srun sgw_cpu.x
