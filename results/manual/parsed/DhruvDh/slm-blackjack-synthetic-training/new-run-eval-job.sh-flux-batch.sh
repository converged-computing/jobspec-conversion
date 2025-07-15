#!/bin/bash
#FLUX: --job-name=eval_task
#FLUX: -c=16
#FLUX: --queue=GPU
#FLUX: -t=7200
#FLUX: --priority=16

export TOKENIZERS_PARALLELISM='false'

checkpoint_dirs=(
  "/users/ddhamani/8156/slm-blackjack-synthetic-training/checkpoints/FINAL-2048"
  "/users/ddhamani/8156/slm-blackjack-synthetic-training/checkpoints/FINAL-4096"
  "/users/ddhamani/8156/slm-blackjack-synthetic-training/checkpoints/FINAL-8192"
)
output_dir="results"
batch_size=1
export TOKENIZERS_PARALLELISM="false"
module load singularity
processed_file="processed_checkpoints.txt"
touch "$processed_file" # Create the processed_file if it doesn't exist
eval_batches=(3000 6000 9000 12000 15000 18000 21000 24000)
checkpoint_dir_index=$((SLURM_ARRAY_TASK_ID / ${#eval_batches[@]}))
batch_index=$((SLURM_ARRAY_TASK_ID % ${#eval_batches[@]}))
checkpoint_dir="${checkpoint_dirs[checkpoint_dir_index]}"
batch="${eval_batches[batch_index]}"
context_window="${checkpoint_dir##*-}"
checkpoint_file="$checkpoint_dir/ep0-ba${batch}-rank0.pt"
if [[ -f "$checkpoint_file" ]]; then
  for jsonl_file in data-final/eval-icl/*.jsonl; do
    if ! grep -q "$checkpoint_file,$jsonl_file" "$processed_file"; then
      echo "Evaluating $jsonl_file with $checkpoint_file:"
      srun singularity exec --nv nvidia.sif bash -c ". ~/.bashrc && conda activate pytorch && python new-eval.py --checkpoint_path '$checkpoint_file' --jsonl_file '$jsonl_file' --output_dir '$output_dir' --context_window '$context_window' --batch_size '$batch_size' --use_gpu"
      # Write the processed checkpoint and jsonl file to the processed_file
      echo "$checkpoint_file,$jsonl_file" >>"$processed_file"
      rm -rf tokenizer-save-dir-*
    fi
  done
fi
