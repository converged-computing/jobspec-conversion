#!/bin/bash
#FLUX --job-name=pusheena-hope-2688
#FLUX -n=4
#FLUX --queue=maxwell
#FLUX -t=3600
#FLUX --urgency=16

setpkgs -a tensorflow_0.12
source activate FCN
cd /scratch/yaoy4/BodySegmentation
python test_tf.py
