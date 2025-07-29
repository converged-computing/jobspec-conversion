#!/bin/bash
#SBATCH --job-name=TRLM_little
#SBATCH --account=tc046-jtaylor
#SBATCH --output=logs/training/%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=4-00:00:00
#SBATCH --qos=gpu

pwd; hostname; date
source /work/tc046/tc046/jamesetay1/subword-to-word/venv/bin/activate
python main.py \
--cuda \
--epochs 50 \
--model Transformer \
--data ./data/wikitext-103 \
--batch_size 64
date
