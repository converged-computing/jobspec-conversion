#!/bin/bash
#FLUX: --job-name=muffled-lizard-4789
#FLUX: --priority=16

module load cuda/8.0 cudnn/5.1
module load tensorflow-gpu
python3 one_shot_learning.py --dataset_type=kinetics_dynamic --controller_type=alex --batch_size=16 --image_width=128  --image_height=128 --summary_writer=True --model_saver=False --debug=True --memory_size=128 --memory_vector_dim=40 --seq_length=100 --n_classes=25 --class_difficulty=medium --use_pretrained=False --num_epoches=1000 --rnn_size=200 --batches_validation=5
