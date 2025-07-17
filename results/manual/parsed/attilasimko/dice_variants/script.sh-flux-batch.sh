#!/bin/bash
#FLUX: --job-name=angry-noodle-6656
#FLUX: --queue=alvis
#FLUX: -t=86400
#FLUX: --urgency=16

export var1='$1'
export var2='$2'
export var3='$3'

module load TensorFlow/2.11.0-foss-2022a-CUDA-11.7.0
source /cephyr/users/attilas/Alvis/venv/bin/activate
export var1=$1
export var2=$2
export var3=$3
python3 training.py --base alvis --optimizer "SGD" --skip_background "False" --batch_size 12 --dataset $var3 --num_epochs 200 --loss $var1 --learning_rate $var2
wait
