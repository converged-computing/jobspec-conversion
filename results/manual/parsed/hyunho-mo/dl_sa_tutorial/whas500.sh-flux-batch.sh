#!/bin/bash
#FLUX: --job-name=tf_hello
#FLUX: --urgency=16

module purge
module load Python/3.7.4-GCCcore-8.3.0
source /trinity/home/hmo/hmo/hmo_dl/bin/activate 
echo "deepsurv toturial"
python3 deepsurv_pytorch.py -dataset "whas500.xls" -model ~/hmo/dl_sa_tutorial/experiments/deepsurv/models/whas500_model_relu_revision.0.json --update_fn "adam" --num_epochs "300"
