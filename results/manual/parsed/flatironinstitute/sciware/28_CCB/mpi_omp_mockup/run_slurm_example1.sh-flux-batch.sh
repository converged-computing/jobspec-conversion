#!/bin/bash
#FLUX: --job-name=mpi_omp_example1
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --queue=ccb
#FLUX: -t=600
#FLUX: --urgency=16

module -q purge                       # purge current modules
module -q load openmpi                # Load openmpi
module list                           # What modules are loaded?
lscpu                                 # What cpus do we have?
nvidia-smi                            # Is there gpu information?
numactl -H                            # What is the NUMA layout
echo "Slurm nodes:              ${SLURM_NNODES}"
echo "Slurm ntasks:             ${SLURM_NTASKS}"
echo "Slurm ntasks-per-node:    ${SLURM_NTASKS_PER_NODE}"
echo "Slurm cpus-per-task:      ${SLURM_CPUS_PER_TASK}"
OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK} mpirun mpi_omp_mockup
