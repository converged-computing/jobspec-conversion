#!/bin/bash
#FLUX: --job-name=confused-butter-3195
#FLUX: -t=1440
#FLUX: --urgency=16

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python /home/rbbidart/cancer_hist/src/model_test.py project/rbbidart/cancer_hist/extracted_cells_128 /home/rbbidart/cancer_hist/output/size128_class 160 100 128 conv_incp3
