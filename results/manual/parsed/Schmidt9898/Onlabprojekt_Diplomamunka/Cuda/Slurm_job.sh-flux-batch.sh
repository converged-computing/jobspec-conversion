#!/bin/bash
#FLUX: --job-name=tile_800
#FLUX: -t=36000
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='1'

echo "helo from slurm"
echo "init modules"
source /usr/share/Modules/init/bash
cd /home/schmidtl/Onlabprojekt/Develop/
source ../start 15.3
source /home/schmidtl/Onlabprojekt/py_venv/bin/activate
which python3
export CUDA_VISIBLE_DEVICES=1
pwd
nvidia-smi
python3 ./performance_test_for_tile.py
echo "done"
