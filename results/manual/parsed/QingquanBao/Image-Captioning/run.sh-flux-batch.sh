#!/bin/bash
#FLUX: --job-name=angry-motorcycle-7096
#FLUX: --priority=16

python main.py train_evaluate --config_file configs/resnet101_attention_schedule.yaml 
python evaluate.py --prediction_file experiments/resnet101_attention_schedule2/resnet101_attention_b128_emd300_predictions.json \
                 --reference_file /dssg/home/acct-stu/stu464/data/image_caption/caption.txt \
                 --output_file result.txt
