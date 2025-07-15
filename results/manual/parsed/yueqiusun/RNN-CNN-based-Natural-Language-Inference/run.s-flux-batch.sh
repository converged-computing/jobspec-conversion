#!/bin/bash
#FLUX: --job-name=nlp
#FLUX: -t=64800
#FLUX: --priority=16

for mul in  0
do
python main.py --model RNN --num_epochs 10 --hidden_size 200 --kernel_size 3 --mul $mul --learning_rate 0.001 --dropout -1 --save_model 1
done
