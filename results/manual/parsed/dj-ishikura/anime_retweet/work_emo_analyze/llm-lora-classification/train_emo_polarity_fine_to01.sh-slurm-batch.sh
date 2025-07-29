#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/dj-ishikura/anime_retweet/work_emo_analyze/llm-lora-classification/train_emo_polarity_fine_to01.sh
