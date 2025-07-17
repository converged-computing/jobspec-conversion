#!/bin/bash
#FLUX: --job-name=HPC_WITH_PYTHON_Reynold_Strouhal
#FLUX: -N=2
#FLUX: --queue=multiple
#FLUX: -t=2400
#FLUX: --urgency=16

module load devel/python/3.8.1_gnu_9.2-pipenv
module load mpi/openmpi/4.0
echo "Running on ${SLURM_JOB_NUM_NODES} nodes with ${SLURM_JOB_CPUS_PER_NODE} cores each."
echo "Each node has ${SLURM_MEM_PER_NODE} of memory allocated to this job."
time mpirun python src/main.py -f "reynold_strouhal"
