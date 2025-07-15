#!/bin/bash
#FLUX: --job-name=fn
#FLUX: -c=32
#FLUX: --queue=fvl
#FLUX: -t=172800
#FLUX: --urgency=16

python ForgeryNet.py -path '/share/home/zhangchao/datasets_io03_ssd/ForgeryNet' -save_path '/share/home/zhangchao/datasets_io03_ssd/ForgeryNet' -scale 1.3 -detector dlib -workers 32
