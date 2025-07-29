#!/bin/bash
#FLUX --job-name=rainbow-earthworm-1400
#FLUX --urgency=16

module load openmpi/3.0.0
PYTHON_PROGRAM=${PYTHON_PROGRAM:-python3}
RUN_COMMAND=${RUN_COMMAND:-srun --mpi=openmpi}
exec ${RUN_COMMAND} ${PYTHON_PROGRAM} mpi4.py
