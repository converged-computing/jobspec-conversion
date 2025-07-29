#!/bin/bash
#SBATCH --job-name=GMX_test
#SBATCH --account=ta059
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=standard
#SBATCH --qos=short

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load gromacs
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun -n 1 \
  gmx_mpi mdrun -ntomp ${SLURM_CPUS_PER_TASK} -nsteps 10000 -s npt.tpr
