#!/bin/bash
#SBATCH --output=%j.stdout
#SBATCH --error=%j.stderr
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=128
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

export KMP_AFFINITY='SCATTER'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load intel-ics intel-impi
export KMP_AFFINITY=SCATTER
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun ./mpi-prog
