#!/bin/bash
#FLUX: --job-name=hw0_test
#FLUX: --queue=normal
#FLUX: -t=120
#FLUX: --priority=16

. /home/fagg/tf_setup.sh
conda activate tf
python HW0.py --exp 1 --epochs 1000 --hidden 500 --lrate 0.0000001
