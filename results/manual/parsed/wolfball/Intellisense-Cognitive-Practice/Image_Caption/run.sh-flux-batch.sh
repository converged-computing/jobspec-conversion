#!/bin/bash
#FLUX: --job-name=carnivorous-pastry-5812
#FLUX: --queue=a100
#FLUX: --urgency=16

python main.py train_evaluate --config_file configs/resnet101_attention.yaml --outputpath experiments/best --schedule_sampling cycle --sample_k 5 --cudaid $1
