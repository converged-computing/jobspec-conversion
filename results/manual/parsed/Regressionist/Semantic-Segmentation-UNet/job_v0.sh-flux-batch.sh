#!/bin/bash
#FLUX: --job-name=CITY_V0
#FLUX: -c=3
#FLUX: -t=172680
#FLUX: --urgency=16

module load python-3.6
module load cuda-10.0
source /data/sk7685/pytorch_10/bin/activate pytorch_10
srun python3 train.py -s 0 -e 10 -a 0 -v v0 -w wv0 -x wv0 -o adam -l 0.001 -d 0.20 -m 100
srun python3 train.py -s 10 -e 15 -a 1 -v v0 -w wv0 -x wv0 -o adam -l 0.001 -d 0.20 -m 100
srun python3 train.py -s 25 -e 40 -a 0 -v v0 -w wv0 -x wv0 -o adam -l 0.001 -d 0.20 -m 100
