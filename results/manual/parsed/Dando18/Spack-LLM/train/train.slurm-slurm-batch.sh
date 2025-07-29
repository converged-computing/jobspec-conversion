#!/bin/bash
#SBATCH --job-name=train
#SBATCH --account=bhatele-lab-aac
#SBATCH --output=train-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=a100:4
#SBATCH --mem=512000
#SBATCH --time=15:00:00

export HF_HOME='~/scratch/.cache/huggingface'
export TOKENIZERS_PARALLELISM='false'
export OMP_NUM_THREADS='4'

cd ~/spackllm/train
module load cuda/11.6.2/gcc/9.4.0/ python
source ~/scratch/spackllm/.env/bin/activate
export HF_HOME=~/scratch/.cache/huggingface
export TOKENIZERS_PARALLELISM=false
export OMP_NUM_THREADS=4
accelerate launch \
    --config_file=accelerate-zero3-config.yaml \
    --machine_rank=0 \
    train.py \
        --model_name codellama/CodeLlama-13b-hf \
        --dataset_name daniellnichols/package-metadata \
        --dataset_text_field "text" \
        --learning_rate 1.41e-5 \
        --batch_size 1 \
        --seq_length 16384 \
        --num_train_epochs 3 \
        --output_dir ~/scratch/spackllm/output-13b \
        --save_steps 100 \
        --save_total_limit 1 \
        --gradient_accumulation_steps 16 \
        --gradient_checkpointing True \
        --mixed_precision bf16 \
        --num_workers 8 \
        --packing False
