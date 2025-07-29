#!/bin/bash
#SBATCH --job-name=gmx
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=00:10:00
#SBATCH --partition=cn
#SBATCH --constraint=ntasks-per-node=128

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module load gromacs/2021/2021.4-intel-nogpu-openmpi-gcc
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
mpirun gmx_mpi mdrun -ntomp ${SLURM_CPUS_PER_TASK} -v -s benchMEM.tpr
