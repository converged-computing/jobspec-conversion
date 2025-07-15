#!/bin/bash
#FLUX: --job-name=gassy-cattywampus-9982
#FLUX: -c=4
#FLUX: --priority=16

source activate pytorch_p37
cd /home/ianpan/ufrc/deepfake/skp/etl
/home/ianpan/anaconda3/envs/pytorch_p37/bin/python face_xray.py --start 25000 --end 50000
