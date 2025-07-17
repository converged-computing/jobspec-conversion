#!/bin/bash
#FLUX: --job-name=unify_mm_v100
#FLUX: -N=8
#FLUX: -c=64
#FLUX: --exclusive
#FLUX: --queue=mm_v100_32g
#FLUX: --urgency=16

export NCCL_PROTO='simple'
export FI_EFA_FORK_SAFE='1'
export FI_LOG_LEVEL='1'
export FI_EFA_USE_DEVICE_RDMA='1 # use for p4dn'
export NCCL_DEBUG='info'
export PYTHONFAULTHANDLER='1'
export CUDA_LAUNCH_BLOCKING='0'
export OMPI_MCA_mtl_base_verbose='1'
export FI_EFA_ENABLE_SHM_TRANSFER='0'
export FI_PROVIDER='efa'
export FI_EFA_TX_MIN_CREDITS='64'
export NCCL_TREE_THRESHOLD='0'
export HOSTNAMES='`scontrol show hostnames "$SLURM_JOB_NODELIST"`'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export COUNT_NODE='`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`'

set -e
export NCCL_PROTO=simple
export FI_EFA_FORK_SAFE=1
export FI_LOG_LEVEL=1
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4dn
export NCCL_DEBUG=info
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0
export OMPI_MCA_mtl_base_verbose=1
export FI_EFA_ENABLE_SHM_TRANSFER=0
export FI_PROVIDER=efa
export FI_EFA_TX_MIN_CREDITS=64
export NCCL_TREE_THRESHOLD=0
export HOSTNAMES=`scontrol show hostnames "$SLURM_JOB_NODELIST"`
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
if [ "$MASTER_PORT" == "" ]; then
  export MASTER_PORT=12802
  echo "MASTER_PORT IS NULL. USE DEFAULT PORT: ${MASTER_PORT}"
fi
export COUNT_NODE=`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`
echo "*********** sbatch launch summary ****************"
echo MASTER_PORT: $MASTER_PORT
echo MASTER_ADDR: $MASTER_ADDR
echo COUNT_NODE: $COUNT_NODE
echo HOSTNAMES: $HOSTNAMES
echo "**************************************************"
set -x
/mnt/lustre/share/intel64_cluster/impi/2017.1.132/bin64/mpirun -n $COUNT_NODE -perhost 1 start_in_container.sh $@
