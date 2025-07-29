#!/bin/bash
#SBATCH --job-name=llama7b-2
#SBATCH --output=llama-2-7b.%j.out
#SBATCH --error=llama-2-7b.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=0
#SBATCH --time=3-00:00:00
#SBATCH --qos=your_assigned_qos
#SBATCH --constraint=ntasks-per-node=1

export NCCL_IB_DISABLE='1  # Our cluster does not have InfiniBand. We need to disable usage using this flag.'
export NCCL_DEBUG='WARN'
export NCCL_DEBUG_SUBSYS='WARN'
export LOGLEVEL='INFO'
export PYTHONFAULTHANDLER='1'

export NCCL_IB_DISABLE=1  # Our cluster does not have InfiniBand. We need to disable usage using this flag.
export NCCL_DEBUG=WARN
export NCCL_DEBUG_SUBSYS=WARN
export LOGLEVEL=INFO
export PYTHONFAULTHANDLER=1
torchrun --nnodes=1 --nproc-per-node=${SLURM_GPUS_ON_NODE} llama_example.py --yaml_path ../configs/config.yaml
