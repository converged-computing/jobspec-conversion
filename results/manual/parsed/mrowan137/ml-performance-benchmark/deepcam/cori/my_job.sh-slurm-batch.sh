#!/bin/bash
#SBATCH --job-name=deepcam-cgpu
#SBATCH --account=nstaff
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --exclusive
#SBATCH --constraint=gpu,ntasks-per-node=8

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
