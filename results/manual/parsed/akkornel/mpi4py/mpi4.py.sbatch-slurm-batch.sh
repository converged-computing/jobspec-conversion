#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module load openmpi/3.0.0
PYTHON_PROGRAM=${PYTHON_PROGRAM:-python3}
RUN_COMMAND=${RUN_COMMAND:-srun --mpi=openmpi}
exec ${RUN_COMMAND} ${PYTHON_PROGRAM} mpi4.py
