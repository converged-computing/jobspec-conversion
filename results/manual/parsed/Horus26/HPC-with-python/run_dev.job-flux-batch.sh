#!/bin/bash
#FLUX: --job-name=moolicious-hippo-1174
#FLUX: -N=4
#FLUX: --queue=dev_multiple
#FLUX: -t=1800
#FLUX: --priority=16

module load devel/python/3.10.0_gnu_11.1
module load compiler/gnu/12.1
module load mpi/openmpi/4.1
module list
echo "Running on ${SLURM_JOB_NUM_NODES} nodes with ${SLURM_JOB_CPUS_PER_NODE} cores each."
echo "Each node has ${SLURM_MEM_PER_NODE} of memory allocated to this job."
time mpirun python3 Milestone7_Parallelization_Dev.py
