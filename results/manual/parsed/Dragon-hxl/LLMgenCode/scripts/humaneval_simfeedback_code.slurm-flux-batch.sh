#!/bin/bash
#FLUX: --job-name=muffled-hippo-5140
#FLUX: -c=32
#FLUX: --urgency=16

echo "Job start at $(date "+%Y-%m-%d %H:%M:%S")"
echo "Job run at:"
echo "$(hostnamectl)"
source /tools/module_env.sh
module list                       # list modules loaded
module load cluster-tools/v1.0
module load slurm-tools/v1.0
module load cmake/3.21.7
module load python3/3.8.16
module load cuda-cudnn/11.6-8.4.1
echo $(module list)              # list modules loaded
echo $(which gcc)
echo $(which python)
echo $(which python3)
cluster-quota                    # nas quota
nvidia-smi --format=csv --query-gpu=name,driver_version,power.limit # gpu info
echo "Use GPU ${CUDA_VISIBLE_DEVICES}"                              # which gpus
cd ~/codex/codellama
torchrun --nproc_per_node 2 humaneval_simfeedback_codellama.py --ckpt_dir /lustre/S/liuchenxiao/@datasets/llama2/codellama.model/CodeLlama-13b-Python --tokenizer_path /lustre/S/liuchenxiao/@datasets/llama2/codellama.model/CodeLlama-13b-Python/tokenizer.model --max_seq_len 5120 --max_batch_size 4
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
