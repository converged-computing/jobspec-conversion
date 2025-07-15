#!/bin/bash
#FLUX: --job-name=mistral16
#FLUX: --queue=a100
#FLUX: -t=115200
#FLUX: --priority=16

module load gcc/9.3.0
module load cuda/12.1.0
module load anaconda
source activate test
nvidia-smi -l 5 > gpu_usage-mistral16.log &
PID=$!
python code/t1.py -s S1 -mn mistral -mh mistralai/Mistral-7B-v0.1 -b 4
kill $PID
