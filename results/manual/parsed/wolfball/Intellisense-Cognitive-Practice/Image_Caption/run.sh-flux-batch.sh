#!/bin/bash
#FLUX: --job-name=eccentric-peas-1579
#FLUX: --urgency=16

python main.py train_evaluate --config_file configs/resnet101_attention.yaml --outputpath experiments/best --schedule_sampling cycle --sample_k 5 --cudaid $1
