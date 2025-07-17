#!/bin/bash
#FLUX: --job-name=faux-chip-7734
#FLUX: --queue=nvidia
#FLUX: -t=41400
#FLUX: --urgency=16

export DATA_DIR='data/alhafni'

nvidia-smi
module purge
export DATA_DIR=data/alhafni
python main.py \
 --data_dir $DATA_DIR \
 --embed_trg_gender \
 --analyzer_db_path /scratch/ba63/databases/calima-msa/calima-msa.0.2.2.utf8.db \
 --use_morph_features \
 --trg_gender_embedding_dim 10 \
 --embedding_dim 128 \
 --hidd_dim 256 \
 --num_layers 2 \
 --learning_rate 5e-4 \
 --seed 21 \
 --model_path saved_models/joint_models/joint+morph.pt \
 --do_inference \
 --inference_mode dev \
 --preds_dir logs/reinflection/joint_models/dev.joint+morph
