#!/bin/bash
#FLUX: --job-name=nemo--15B-16g
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export TRANSFORMERS_OFFLINE='0'
export TORCH_NCCL_AVOID_RECORD_STREAMS='1'
export NCCL_NVLS_ENABLE='1'
export NVTE_DP_AMAX_REDUCE_INTERVAL='0'
export NVTE_ASYNC_AMAX_REDUCTION='1'
export NVTE_FUSED_ATTN='0'
export FI_PROVIDER='efa'
export FI_EFA_USE_DEVICE_RDMA='1'
export FI_EFA_FORK_SAFE='1'
export NCCL_IB_DISABLE='1'
export NCCL_IBEXT_DISABLE='1'
export NVTE_FWD_LAYERNORM_SM_MARGIN='16'
export NVTE_BWD_LAYERNORM_SM_MARGIN='16'
export OFI_NCCL_ROUND_ROBIN_THRESHOLD='262144'
export OFI_NCCL_GDR_FLUSH_DISABLE='1'

export NCCL_DEBUG=INFO
export TRANSFORMERS_OFFLINE=0
export TORCH_NCCL_AVOID_RECORD_STREAMS=1
export NCCL_NVLS_ENABLE=1
export NVTE_DP_AMAX_REDUCE_INTERVAL=0
export NVTE_ASYNC_AMAX_REDUCTION=1
export NVTE_FUSED_ATTN=0
export FI_PROVIDER=efa
export FI_EFA_USE_DEVICE_RDMA=1
export FI_EFA_FORK_SAFE=1
export NCCL_IB_DISABLE=1
export NCCL_IBEXT_DISABLE=1
export NVTE_FWD_LAYERNORM_SM_MARGIN=16
export NVTE_BWD_LAYERNORM_SM_MARGIN=16
export OFI_NCCL_ROUND_ROBIN_THRESHOLD=262144
export OFI_NCCL_GDR_FLUSH_DISABLE=1
srun --container-image /fsx/nemotron/nemotron-nccl-efa.sqsh --container-mounts /home/ubuntu:/home/ubuntu,/fsx:/fsx --no-container-mount-home --mpi=pmix bash -c "
  cd /opt/NeMo;
  git rev-parse HEAD;
  export PYTHONPATH=/opt/NeMo:\${PYTHONPATH};
  CUDA_DEVICE_MAX_CONNECTIONS=1 CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 nsys profile -s none -t nvtx,cuda -o /fsx/nemotron/nsight-awsankur/results/nemotron4--15B-16g/profile_logs/profile_\${SLURM_JOB_ID}_node\${SLURM_NODEID}_rank\${SLURM_PROCID} --force-overwrite true --capture-range=cudaProfilerApi --capture-range-end=stop python3 -u /opt/NeMo/examples/nlp/language_modeling/megatron_gpt_pretraining.py  \
  --config-path=/fsx/nemotron/nsight-awsankur \
  --config-name=nemotron4--15B-16g_hydra.yaml \
  model.gc_interval=100"
