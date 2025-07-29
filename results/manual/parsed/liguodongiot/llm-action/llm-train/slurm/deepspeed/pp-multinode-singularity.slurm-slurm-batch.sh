#!/bin/bash
#SBATCH --job-name=multinode-deepspeed-singularity
#SBATCH --output=log/%j.out
#SBATCH --error=log/%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=20:00:00

export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='bond0'
export CC='/opt/hpcx/ompi/bin/mpicc'
export CUDA_LAUNCH_BLOCKING='1'

export NCCL_IB_DISABLE=1
export NCCL_SOCKET_IFNAME=bond0
export CC=/opt/hpcx/ompi/bin/mpicc
export CUDA_LAUNCH_BLOCKING=1
srun --mpi=pmi2 singularity run --nv --pwd /workspaces/DeepSpeedExamples-20230430/training/pipeline_parallelism \
-B /data/hpc/home/guodong.li/:/workspaces:rw \
deepspeed.sif \
python -m torch.distributed.run \
--nproc_per_node 2 \
train.py --deepspeed_config=ds_config.json -p 2 --steps=200
