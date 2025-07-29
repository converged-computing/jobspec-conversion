#!/bin/bash
#SBATCH --job-name=34b-instruct-codereview-new
#SBATCH --account=punim2247
#SBATCH --output=logs/34b-instruct-codereview-new.log
#SBATCH --mail-user=mukhammad.karimov@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --mem=100G
#SBATCH --time=1-16:00:00
#SBATCH --partition=deeplearn
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
torchrun --nproc_per_node 4 code_review_instructions.py \
    --ckpt_dir ./ckpt/CodeLlama-34b-Instruct/ \
    --tokenizer_path ./ckpt/CodeLlama-34b-Instruct/tokenizer.model \
    --conf_path ../config/codellama-34b-instruct-codereview-new.json \
    --temperature 0.0 \
    --top_p 0.95 \
    --max_seq_len 4096 \
    --max_batch_size 10 \
    --debug True
my-job-stats -c -n -s
my-job-stats -a -n -s
nvidia-smi
