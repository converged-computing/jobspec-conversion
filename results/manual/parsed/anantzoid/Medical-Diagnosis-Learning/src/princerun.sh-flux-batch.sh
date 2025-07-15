#!/bin/bash
#FLUX: --job-name=attention_test
#FLUX: -t=86400
#FLUX: --priority=16

module purge
module load python/intel/2.7.12
module load pytorch/0.2.0_1
module load tensorboard_logger/0.0.3
module load scikit-learn/intel/0.18.1
python master_train_script.py --train_path /scratch/lhg256/nlp/mimic/50codesL5_UNK_content_4_top100_train_data.pkl --val_path /scratch/lhg256/nlp/mimic/50codesL5_UNK_content_4_top100_valid_data.pkl --model_dir /scratch/lhg256/nlp/mimic --attention 1 --num_workers 12 --embed_path /scratch/lhg256/nlp/stsp_model.tsv --num_epochs 15 --exp_name attention1_50_content4_top100_stsp --use_starspace 1 --multilabel 1 --batch_size 8 --lr 1e-3
