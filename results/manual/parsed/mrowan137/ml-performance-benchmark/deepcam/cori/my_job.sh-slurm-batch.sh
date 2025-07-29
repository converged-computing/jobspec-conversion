#!/bin/bash
#FLUX: --job-name=deepcam-cgpu
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: -t=7200
#FLUX: --urgency=16

export BATCHSIZE='2'
export DO_PROFILING='false'  # true or false'
export DO_NCCL_DEBUG='false' # true or false'
export NODES='${SLURM_NNODES}'

export BATCHSIZE=2
export DO_PROFILING='false'  # true or false
export DO_NCCL_DEBUG='false' # true or false
module load cgpu
module load pytorch/v1.6.0-gpu
export NODES=${SLURM_NNODES}
if [ "$DO_PROFILING" == "true" ]
then
    module load nsight-systems
    srun -N $SLURM_NNODES -n $((SLURM_NNODES*8)) -c 10 \
         --cpu-bind=cores \
         ./utils/run_with_profiling.sh
else
    srun -N $SLURM_NNODES -n $((SLURM_NNODES*8)) -c 10 \
         --cpu-bind=cores \
         ./utils/run.sh
fi
