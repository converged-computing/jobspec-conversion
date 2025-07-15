#!/bin/bash
#FLUX: --job-name=strawberry-carrot-4267
#FLUX: --exclusive
#FLUX: --priority=16

MODEL_NAME="medalpaca-7b"
echo "Starting sbatch script at `date` for $MODEL_NAME"
MODEL_PATH="/mnt/lustre/scratch/nlsas/home/res/cns10/SHARE/Models_Trained/llm/$MODEL_NAME"
CURRENT_DIR=$(pwd)
echo "Current directory: '$CURRENT_DIR'"
module load singularity/3.9.7
singularity exec -B /mnt --nv /mnt/lustre/scratch/nlsas/home/res/cns10/SHARE/Singularity/lm_eval_harness042_vllm032_cuda118.sif \
    bash -c 'export HF_DATASETS_CACHE="/mnt/lustre/scratch/nlsas/home/res/cns10/SHARE/user_caches/hf_cache_'${USER}'" && \
    TORCH_USE_CUDA_DSA=1 python -m lm_eval \
    --model vllm \
    --model_args pretrained='${MODEL_PATH}',tensor_parallel_size=1,trust_remote_code=True,dtype=auto,gpu_memory_utilization=0.7 \
    --tasks jigsaw_toxicity,jigsaw_toxic_prompts \
    --batch_size auto:4 \
    --num_fewshot 0'
