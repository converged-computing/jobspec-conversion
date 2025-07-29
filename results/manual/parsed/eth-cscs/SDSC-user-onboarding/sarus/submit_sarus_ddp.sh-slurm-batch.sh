#!/bin/bash
#SBATCH --job-name=sdsc-ddp
#SBATCH --account=sd00
#SBATCH --output=logs/slurm-%x.%j.out
#SBATCH --error=logs/slurm-%x.%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NCCL_DEBUG='INFO'
export NCCL_NET_GDR_LEVEL='PHB'
export MASTER_ADDR='$(hostname)'

args="${@}"
module load daint-gpu
module load sarus
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NCCL_DEBUG=INFO
export NCCL_NET_GDR_LEVEL=PHB
export MASTER_ADDR=$(hostname)
echo "SLURM: Running sbatch script on ${MASTER_ADDR}"
echo "SLURM: Working in $(pwd) - about to launch srun command."
set -x
srun -ul sarus run --workdir "$(pwd)" --mount type=bind,source=/scratch,destination=/scratch --mount type=bind,source=${HOME},destination=${HOME} nvcr.io/nvidia/pytorch:23.09-py3 bash -c "
    source ./export_DDP_vars.sh
    python -u ${args}
    "
