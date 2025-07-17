#!/bin/bash
#FLUX: --job-name=eccentric-nunchucks-6691
#FLUX: -n=4
#FLUX: --queue=maxwell
#FLUX: -t=3600
#FLUX: --urgency=16

setpkgs -a tensorflow_0.12
source activate FCN
cd /scratch/yaoy4/BodySegmentation
python test_tf.py
