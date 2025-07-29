#!/bin/bash
#SBATCH --job-name=lmp_bench
#SBATCH --account=ta132
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:20:00
#SBATCH --qos=short
#SBATCH --exclusive

export OMP_NUM_THREADS='1'

module load lammps/8Feb2023-gcc8-impi-cuda118
export OMP_NUM_THREADS=1
PARAMS="--ntasks=10 --hint=nomultithread --cpus-per-task=1"
srun ${PARAMS} lmp -pk gpu 1 -sf gpu -in in.ethanol -l log.out_${SLURM_TASKS_PER_NODE}
