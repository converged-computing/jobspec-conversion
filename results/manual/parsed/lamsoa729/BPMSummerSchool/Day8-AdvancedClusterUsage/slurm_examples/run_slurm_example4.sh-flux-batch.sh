#!/bin/bash
#FLUX: --job-name=mpi_omp_example4
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --queue=ccb
#FLUX: -t=600
#FLUX: --priority=16

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
