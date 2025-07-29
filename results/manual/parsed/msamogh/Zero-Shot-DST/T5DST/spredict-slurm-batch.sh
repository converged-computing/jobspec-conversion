#!/bin/bash
#SBATCH --output=outfile
#SBATCH --error=errfile
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=a100:2
#SBATCH --mem=8gb
#SBATCH --time=20:00:00

export CUDA_VISIBLE_DEVICES='3,4'

echo wassup
nvidia-smi
module load cuda/11.4.3
export CUDA_VISIBLE_DEVICES=3,4
~/myblue/woz/cai-nlp/venv/bin/python T5.py \
    --mode predict \
    --GPU 1 \
    --slot_lang slottype \
    --ckpt_path save/t5-41000 \
    --only_domain escai
