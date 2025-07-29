#!/bin/bash
#SBATCH --job-name=mpi_omp_example4
#SBATCH --output=mpi_omp_example4.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=8,rome,ib

module -q purge
module -q load openmpi
module list
lscpu
nvidia-smi
echo "Slurm nodes:              ${SLURM_NNODES}"
echo "Slurm ntasks:             ${SLURM_NTASKS}"
echo "Slurm ntasks-per-node:    ${SLURM_NTASKS_PER_NODE}"
echo "Slurm cpus-per-task:      ${SLURM_CPUS_PER_TASK}"
OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK} mpirun -np ${SLURM_NTASKS} mpi_omp_mockup
