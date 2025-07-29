#!/bin/bash
#FLUX: --job-name=export_int
#FLUX: -c=32
#FLUX: --queue=gp4d
#FLUX: --urgency=16

export PYTHONUSERBASE='$CONDA_PREFIX'
export HF_HOME='/work/twsuzrf718/hf_home'
export MASTER_ADDR='`scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1`'
export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export NCCL_DEBUG='WARN'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_IB_HCA='mlx5_0'
export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:2048'
export OMP_NUM_THREADS='1'
export LAUNCHER='python'
export CMD='bloom_export_int8_model.py'

export PYTHONUSERBASE=$CONDA_PREFIX
export HF_HOME=/work/twsuzrf718/hf_home
echo "NODELIST="$SLURM_JOB_NODELIST
export MASTER_ADDR=`scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1`
export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
export NCCL_DEBUG=WARN
export NCCL_SOCKET_IFNAME=ib0
export NCCL_IB_HCA=mlx5_0
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:2048
export OMP_NUM_THREADS=1
echo "master addr="$MASTER_ADDR
echo "master port="$MASTER_PORT
export LAUNCHER="python"
export CMD="bloom_export_int8_model.py"
srun --jobid $SLURM_JOBID bash -c '$LAUNCHER $CMD'
echo "Finish $(date)"
