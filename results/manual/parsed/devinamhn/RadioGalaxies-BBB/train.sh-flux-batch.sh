#!/bin/bash
#FLUX: --job-name=vi
#FLUX: -t=1380
#FLUX: --priority=16

pwd;
nvidia-smi
echo ">>>start"
source /share/nas2/dmohan/bbb/RadioGalaxies-BBB/venv/bin/activate 
echo ">>>training"
python /share/nas2/dmohan/bbb/RadioGalaxies-BBB/mirabest_bbb.py
