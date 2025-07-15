#!/bin/bash
#FLUX: --job-name=quirky-sundae-3811
#FLUX: -n=4
#FLUX: --queue=maxwell
#FLUX: -t=3600
#FLUX: --priority=16

setpkgs -a tensorflow_0.12
source activate FCN
cd /scratch/yaoy4/BodySegmentation
python test_tf.py
