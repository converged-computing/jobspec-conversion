#!/bin/bash
#FLUX: --job-name=joyous-poo-0669
#FLUX: --priority=16

module load tensorflow/1.8-agave-gpu                                            
module unload python/.2.7.14-tf18-gpu
/packages/7x/python/3.6.5-tf18-gpu/bin/python3 -m pip install --upgrade pip --user
/packages/7x/python/3.6.5-tf18-gpu/bin/python3 -m pip install --upgrade pylibjpeg pylibjpeg-libjpeg pydicom --user
python3.6 -W ignore genesis_lung.py --data $1 --weights $2
