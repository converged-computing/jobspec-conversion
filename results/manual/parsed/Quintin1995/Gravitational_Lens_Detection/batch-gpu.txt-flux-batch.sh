#!/bin/bash
#FLUX: --job-name=rainbow-kerfuffle-7118
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 cnn.py
