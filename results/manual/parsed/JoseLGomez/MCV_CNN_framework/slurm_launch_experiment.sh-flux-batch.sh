#!/bin/bash
#FLUX: --job-name=adorable-spoon-4365
#FLUX: -n=4
#FLUX: --queue=dcc
#FLUX: -t=605
#FLUX: --urgency=16

sleep 5
/usr/local/cuda-9.2/samples/bin/x86_64/linux/release/deviceQuery
nvidia-smi
cd ~/tmp/MCV_CNN_framework
python main.py --silent --exp_name test01 --exp_folder test01 --config_file config/SemSeg_sample_fcn8_Camvid.yml
