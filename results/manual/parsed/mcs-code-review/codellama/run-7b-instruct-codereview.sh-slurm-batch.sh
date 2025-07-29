#!/bin/bash
#SBATCH --job-name=7b-instruct-codereview
#SBATCH --account=punim2247
#SBATCH --output=logs/7b-instruct-codereview.log
#SBATCH --mail-user=mukhammad.karimov@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --qos=gpgpudeeplearn
#SBATCH --constraint=dlg5

echo "Current modules:"
echo "$(module list)"
echo "Loading modules..."
module load foss/2022a
module load CUDA/12.2.0
module load NCCL/2.19.4-CUDA-12.2.0
module load UCX-CUDA/1.14.1-CUDA-12.2.0
module load cuDNN/8.9.3.28-CUDA-12.2.0
module load GCCcore/11.3.0
module load Python/3.10.4
echo "Loaded modules:"
echo "$(module list)"
source ~/venvs/codellama/bin/activate
torchrun --nproc_per_node 1 code_review_instructions.py \
    --ckpt_dir ./ckpt/CodeLlama-7b-Instruct/ \
    --tokenizer_path ./ckpt/CodeLlama-7b-Instruct/tokenizer.model \
    --conf_path ../config/codellama-7b-instruct-codereview.json \
    --temperature 0.0 \
    --top_p 0.95 \
    --max_seq_len 4096 \
    --max_batch_size 50 \
    --debug True
my-job-stats -c -n -s
my-job-stats -a -n -s
nvidia-smi
