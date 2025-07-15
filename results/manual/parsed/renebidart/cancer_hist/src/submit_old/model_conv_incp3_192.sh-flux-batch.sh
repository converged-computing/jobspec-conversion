#!/bin/bash
#FLUX: --job-name=carnivorous-puppy-3846
#FLUX: -t=1440
#FLUX: --urgency=16

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python /home/rbbidart/cancer_hist/src/model_test.py project/rbbidart/cancer_hist/extracted_cells_192 /home/rbbidart/cancer_hist/output/size192_class 80 64 192 conv_incp3
