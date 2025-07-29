#!/bin/bash
#SBATCH --job-name=10_bert
#SBATCH --output=./10_restaurant.o
#SBATCH --error=./10_restaurant.e
#SBATCH --mail-user=318112194@qq.com
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=20000
#SBATCH --time=00:08:00
#SBATCH --partition=rtx8000,v100

cd /scratch/zt2080/shizhe/eres/BERT-NER-Pytorch-master
python run_ner_softmax.py --model_type=bert\
    --model_name_or_path=bert-base-cased\
    --learning_rate=1e-4\
    --num_train_epochs=10.0\
    --task_name=restaurant_10\
    --data_dir=datasets/restaurant\
    --per_gpu_train_batch_size=12\
    --per_gpu_eval_batch_size=32\
    --use_wandb\
    --cuda=0\
    --train_limit=1000000\
    --eval_limit=100000\
    --test_limit=100000\
