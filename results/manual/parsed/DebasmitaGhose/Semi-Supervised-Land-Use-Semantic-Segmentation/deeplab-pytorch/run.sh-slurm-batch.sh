#!/bin/bash
#FLUX: --job-name=DeepLab_VOC
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

python main.py train --config-path configs/voc12.yaml --cuda
