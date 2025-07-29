#!/bin/bash
#SBATCH --output=outfile
#SBATCH --error=errfile
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=a100:1
#SBATCH --mem=8gb
#SBATCH --time=20:00:00

echo wassup
nvidia-smi
module load cuda/11.4.3
~/myblue/woz/cai-nlp/venv/bin/python T5.py --train_batch_size 2 --GPU 1 --except_domain taxi --slot_lang slottype
