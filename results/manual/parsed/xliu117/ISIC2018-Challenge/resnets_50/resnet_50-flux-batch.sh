#!/bin/bash
#FLUX: --job-name=resnet_50
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

module load Keras/2.1.3-goolfc-2017b-Python-3.6.3
module load OpenCV/3.3.0-foss-2017b-Python-3.6.3
python /scratch/user/kaihe/ISIC/TASK3//resnet_50/resnet_50.py 
