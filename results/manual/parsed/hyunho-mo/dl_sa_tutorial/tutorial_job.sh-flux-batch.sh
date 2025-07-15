#!/bin/bash
#FLUX: --job-name=tf_hello
#FLUX: --urgency=16

module purge
module load TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4  
source /trinity/home/hmo/hmo/hmo_dl/bin/activate 
echo "deepsurv toturial"
python3 deepsurv_tutorial.py -model ~/hmo/dl_sa_tutorial/experiments/deepsurv/models/whas_model_relu_revision.0.json -dataset ~/hmo/dl_sa_tutorial/experiments/data/whas/whas_train_test.h5 -experiment "deepsurv_tutorial" --update_fn "adam"
