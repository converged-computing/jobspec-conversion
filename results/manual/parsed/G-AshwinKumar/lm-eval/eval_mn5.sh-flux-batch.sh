#!/bin/bash
#FLUX: --job-name=eval-mn5
#FLUX: -c=80
#FLUX: -t=7200
#FLUX: --urgency=16

MODEL_NAME="c4ai-command-r-v01"
echo "Starting sbatch script at `date` for $MODEL_NAME"
MODEL_PATH="/gpfs/projects/bsc70/heka/models/$MODEL_NAME"
CURRENT_DIR=$(pwd)
echo "Current directory: '$CURRENT_DIR'"
module load singularity
singularity exec -B /gpfs/projects/bsc70/heka \
                 -B /gpfs/projects/bsc70/heka/repos/tmp_eval_harness/vllm_fix/utils.py:/usr/local/lib/python3.10/dist-packages/vllm/utils.py \
                 -B /gpfs/projects/bsc70/heka/repos/tmp_eval_harness/lm-evaluation-harness/lm_eval/api/task.py:/home/lm-evaluation-harness/lm_eval/api/task.py \
                 -B /gpfs/tapes/MN4/projects/bsc70/hpai/storage/data/heka/Models \
                 -B /gpfs/projects/bsc70/heka/repos/tmp_eval_harness/lm-evaluation-harness/lm_eval/toxigen_generation/toxigen_generation.yaml:/home/lm-evaluation-harness/lm_eval/tasks/toxigen_generation/toxigen_generation.yaml \
                 -B /gpfs/projects/bsc70/heka/repos/tmp_eval_harness/lm-evaluation-harness/lm_eval/toxigen_generation/utils.py:/home/lm-evaluation-harness/lm_eval/tasks/toxigen_generation/utils.py \
                 --nv /gpfs/projects/bsc70/heka/singularity/lm-evaluation-harness/lmharness.sif \
   bash -c 'export HF_HUB_OFFLINE=1 && export HF_HOME=/gpfs/scratch/bsc70/hpai/storage/projects/heka/hf_caches/hf_cache2 && export HF_DATASETS_CACHE="/gpfs/scratch/bsc70/hpai/storage/projects/heka/hf_caches/hf_cache2" && \
    python /home/lm-evaluation-harness/lm_eval \
    --model vllm \
    --model_args pretrained='${MODEL_PATH}',tensor_parallel_size=4,dtype=bfloat16,gpu_memory_utilization=0.9,data_parallel_size=1,max_model_len=8192 \
    --tasks medmcqa \
    --batch_size auto:4 \
    --num_fewshot 0 \
    --output_path '${CURRENT_DIR}/${COMMIT_TAG}.txt' \
    --log_samples'
