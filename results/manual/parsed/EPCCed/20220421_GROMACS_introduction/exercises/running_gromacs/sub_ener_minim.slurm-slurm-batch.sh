#!/bin/bash
#SBATCH --account=ta059
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --qos=short

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load gromacs
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
gmx mdrun -ntomp ${SLURM_CPUS_PER_TASK} -v -s ener_minim.tpr
