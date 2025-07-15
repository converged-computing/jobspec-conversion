#!/bin/bash
#FLUX: --job-name=spicy-signal-2809
#FLUX: -c=4
#FLUX: --urgency=16

source activate pytorch_p37
cd /home/ianpan/ufrc/deepfake/skp/etl
/home/ianpan/anaconda3/envs/pytorch_p37/bin/python face_xray.py --start 25000 --end 50000
