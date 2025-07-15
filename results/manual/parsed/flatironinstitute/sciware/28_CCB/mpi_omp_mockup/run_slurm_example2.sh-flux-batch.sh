#!/bin/bash
#FLUX: --job-name=mpi_omp_example2
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --queue=ccb
#FLUX: -t=600
#FLUX: --urgency=16

module -q purge
module -q load openmpi
module list
lscpu
nvidia-smi
numactl -H
echo "Slurm nodes:              ${SLURM_NNODES}"
echo "Slurm ntasks:             ${SLURM_NTASKS}"
echo "Slurm ntasks-per-node:    ${SLURM_NTASKS_PER_NODE}"
echo "Slurm cpus-per-task:      ${SLURM_CPUS_PER_TASK}"
start_time=$(date +%s)
OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK} mpirun mpi_omp_mockup
end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Elapsed time: $elapsed_time seconds"
