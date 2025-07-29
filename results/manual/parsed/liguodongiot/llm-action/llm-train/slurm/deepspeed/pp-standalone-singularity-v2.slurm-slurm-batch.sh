#!/bin/bash
#FLUX: --job-name=multinode-deepspeed-singularity
#FLUX: -n=4
#FLUX: -c=4
#FLUX: --queue=a800
#FLUX: -t=72000
#FLUX: --urgency=16

export GPUS_PER_NODE='2'
export MASTER_ADDR='$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)'
export MASTER_PORT='9903'
export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='bond0'
export CC='/opt/hpcx/ompi/bin/mpicc'

export GPUS_PER_NODE=2
export MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export MASTER_PORT=9903
export NCCL_IB_DISABLE=1
export NCCL_SOCKET_IFNAME=bond0
export CC=/opt/hpcx/ompi/bin/mpicc
srun --mpi=pmix_v3 singularity run --nv --pwd /workspaces/DeepSpeedExamples-20230430/training/pipeline_parallelism \
-B /data/hpc/home/guodong.li/:/workspaces:rw \
deepspeed.sif \
python -m torch.distributed.run \
--nproc_per_node 4 \
--master_addr $MASTER_ADDR \
train.py --deepspeed_config=ds_config.json -p 2 --steps=200
