#!/bin/bash
#FLUX: --job-name=SUMO   ## name that will show up in the queue
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: --priority=16

export LD_LIBRARY_PATH='/opt/aws-ofi-nccl/lib:/opt/amazon/efa/lib64:/usr/local/cuda-11.0/efa/lib:/usr/local/cuda-11.0/lib:/usr/local/cuda-11.0/lib64:/usr/local/cuda-11.0:/opt/nccl/build/lib:/opt/aws-ofi-nccl-install/lib:/opt/aws-ofi-nccl/lib:$LD_LIBRARY_PATH'
export NCCL_PROTO='simple'
export PATH='/opt/amazon/efa/bin:$PATH'
export LD_PRELOAD='/opt/nccl/build/lib/libnccl.so'
export FI_EFA_FORK_SAFE='1'
export FI_LOG_LEVEL='1'
export FI_EFA_USE_DEVICE_RDMA='1 # use for p4dn'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export CUDA_LAUNCH_BLOCKING='0'
export OMP_NUM_THREADS='6'
export OMPI_MCA_mtl_base_verbose='1'
export FI_EFA_ENABLE_SHM_TRANSFER='0'
export FI_PROVIDER='efa'
export FI_EFA_TX_MIN_CREDITS='64'
export NCCL_TREE_THRESHOLD='0'
export SINGULARITY_OMPI_DIR='/opt/amazon/openmpi'
export SINGULARITYENV_APPEND_PATH='/opt/amazon/openmpi/bin'
export SINGULAIRTYENV_APPEND_LD_LIBRARY_PATH='/opt/amazon/openmpi/lib'
export HOSTNAMES='`scontrol show hostnames "$SLURM_JOB_NODELIST"`'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_IP='`hostname -I | cut -d' ' -f1`'
export MASTER_PORT='8888'
export COUNT_NODE='`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`'
export HOSTNAMES_LIST='`echo $HOSTNAMES | sed 's/ /,/g'`'

module load intelmpi
source /opt/intel/mpi/latest/env/vars.sh
export LD_LIBRARY_PATH=/opt/aws-ofi-nccl/lib:/opt/amazon/efa/lib64:/usr/local/cuda-11.0/efa/lib:/usr/local/cuda-11.0/lib:/usr/local/cuda-11.0/lib64:/usr/local/cuda-11.0:/opt/nccl/build/lib:/opt/aws-ofi-nccl-install/lib:/opt/aws-ofi-nccl/lib:$LD_LIBRARY_PATH
export NCCL_PROTO=simple
export PATH=/opt/amazon/efa/bin:$PATH
export LD_PRELOAD="/opt/nccl/build/lib/libnccl.so"
export FI_EFA_FORK_SAFE=1
export FI_LOG_LEVEL=1
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4dn
export NCCL_DEBUG=info
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0
export OMP_NUM_THREADS=6
export OMPI_MCA_mtl_base_verbose=1
export FI_EFA_ENABLE_SHM_TRANSFER=0
export FI_PROVIDER=efa
export FI_EFA_TX_MIN_CREDITS=64
export NCCL_TREE_THRESHOLD=0
export SINGULARITY_OMPI_DIR=/opt/amazon/openmpi
export SINGULARITYENV_APPEND_PATH=/opt/amazon/openmpi/bin
export SINGULAIRTYENV_APPEND_LD_LIBRARY_PATH=/opt/amazon/openmpi/lib
mpirun --version
export HOSTNAMES=`scontrol show hostnames "$SLURM_JOB_NODELIST"`
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_IP=`hostname -I | cut -d' ' -f1`
export MASTER_PORT=8888
export COUNT_NODE=`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`
export HOSTNAMES_LIST=`echo $HOSTNAMES | sed 's/ /,/g'`
export NCCL_DEBUG=INFO
echo Number of Nodes: $COUNT_NODE
echo Name of all Hosts: $HOSTNAMES
echo Master IP: $MASTER_IP
echo PROC_ID: $SLURM_PROCID
srun /fsx/awesome/torch_runner.sh --comment laion
