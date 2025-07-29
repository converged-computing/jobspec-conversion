#!/bin/bash
#SBATCH --job-name=TDG_SNEE
#SBATCH --output=output/logs2/TDG_SNEE.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:P100:1

CUDA_VISIBLE_DEVICES=0,1 python TC_preprocess.py
CUDA_VISIBLE_DEVICES=0,1 python TC/run_bert.py --do_data 
CUDA_VISIBLE_DEVICES=0,1 python TC/run_bert.py --do_train --save_best
CUDA_VISIBLE_DEVICES=0,1 python TC/run_bert.py --do_test
CUDA_VISIBLE_DEVICES=0,1 python AI_RC_preprocess.py
CUDA_VISIBLE_DEVICES=0,1 python AI_RC/get_data.py
CUDA_VISIBLE_DEVICES=0 python AI_RC/train_start.py
CUDA_VISIBLE_DEVICES=0 python AI_RC/test.py
