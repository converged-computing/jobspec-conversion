#!/bin/bash
#FLUX: --job-name=5_bert
#FLUX: -c=8
#FLUX: --queue=rtx8000,v100
#FLUX: -t=480
#FLUX: --urgency=16

cd /scratch/zt2080/shizhe/eres/BERT-NER-Pytorch-master
python run_ner_softmax.py --model_type=bert\
    --model_name_or_path=bert-base-cased\
    --learning_rate=5e-5\
    --num_train_epochs=10.0\
    --task_name=conll-mrc_5\
    --data_dir=datasets/conll03_mrc\
    --per_gpu_train_batch_size=12\
    --per_gpu_eval_batch_size=32\
    --use_wandb\
    --cuda=0\
    --train_limit=100000\
    --eval_limit=100000\
    --test_limit=100000\
