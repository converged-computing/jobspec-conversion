#!/bin/bash
#FLUX: --job-name=hf_pytorch
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --urgency=16

CMD=$@
if [ -z "${CMD}" ]; then
  echo "No command parameters were passed to the script. This script expects the python script with args to be passed as a parameter."
  exit 1
fi
INSTANCES_PER_NODE="${INSTANCES_PER_NODE:-1}"
if [[ $SLURM_NNODES == 1 ]] && [[ $INSTANCES_PER_NODE == 1 ]]; then
  export CCL_WORKER_COUNT=0
  MPI_CMD=""
else
  # Setup env variables for distributed jobs
  export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
  export MASTER_PORT="${MASTER_PORT:-25679}"
  export WORLD_SIZE=$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE * $INSTANCES_PER_NODE))
  export CCL_WORKER_COUNT="${CCL_WORKER_COUNT:-2}"
  echo "MASTER_ADDR=${MASTER_ADDR}"
  echo "MASTER_PORT=${MASTER_PORT}"
  echo "WORLD_SIZE=${WORLD_SIZE}"
  echo "CCL_WORKER_COUNT=${CCL_WORKER_COUNT}"
  # Write hostfile
  HOSTFILE_PATH=hostfile
  scontrol show hostname $SLURM_JOB_NODELIST | perl -ne 'chomb; print "$_"x1'> ${HOSTFILE_PATH}
  # Create mpirun command
  BIND_TO="${BIND_TO:-socket}"
  MPI_CMD="mpirun --hostfile ${HOSTFILE_PATH} \
    -n $((${SLURM_NNODES} * ${INSTANCES_PER_NODE} )) \
    --bind-to ${BIND_TO} \
    -x MASTER_ADDR=${MASTER_ADDR} \
    -x MASTER_PORT=${MASTER_PORT} \
    -x WORLD_SIZE=${WORLD_SIZE} \
    -x CCL_WORKER_COUNT=${CCL_WORKER_COUNT}"
  if [[ ! -z "${MPI_ARGS}" ]]; then
    MPI_CMD="${MPI_CMD} ${MPI_ARGS}"
  fi
fi
FULL_CMD="${MPI_CMD} python ${CMD}"
echo $FULL_CMD
echo ""
eval $FULL_CMD
