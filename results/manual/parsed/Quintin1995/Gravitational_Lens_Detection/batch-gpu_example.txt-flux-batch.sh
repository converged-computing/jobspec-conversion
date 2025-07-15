#!/bin/bash
#FLUX: --job-name=rainbow-caramel-2588
#FLUX: --queue=gpu
#FLUX: -t=54000
#FLUX: --urgency=16

module load TensorFlow/2.0.0-foss-2019a-Python-3.7.2
module load matplotlib/3.0.3-fosscuda-2019a-Python-3.7.2
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 cnn.py
