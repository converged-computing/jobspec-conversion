#!/bin/bash
#FLUX: --job-name=tart-nalgas-1232
#FLUX: -t=259200
#FLUX: --priority=16

nvidia-smi
python -u train_sep.py \
--code_lang java \
--gpu --model_name sep_model \
--save_dir result_models/sep_models \
--train_code_path data/dual_data/java/train/code.original \
--train_summ_path data/dual_data/java/train/javadoc.original
