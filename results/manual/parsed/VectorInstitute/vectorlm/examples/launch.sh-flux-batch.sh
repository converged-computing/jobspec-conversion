#!/bin/bash
#FLUX: --job-name=llama7b-2
#FLUX: --queue=a100
#FLUX: -t=259200
#FLUX: --priority=16

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
