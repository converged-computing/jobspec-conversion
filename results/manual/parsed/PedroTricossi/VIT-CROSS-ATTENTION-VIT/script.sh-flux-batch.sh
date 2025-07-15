#!/bin/bash
#FLUX: --job-name=my_tensorflow_job
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --priority=16

source activate tensorflow_env
python3 -u ex1_main.py --log-interval 1 --seed 42 --epochs 20000 --model "cvit" 
