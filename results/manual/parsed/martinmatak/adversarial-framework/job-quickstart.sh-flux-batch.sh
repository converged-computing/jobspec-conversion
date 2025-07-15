#!/bin/bash
#FLUX: --job-name=gassy-bicycle-0035
#FLUX: --priority=16

module purge
module load intel/18 python/3.6.4 
source /home/lv71235/mmatak/adversarial_framework/venv/bin/activate
python /home/lv71235/mmatak/adversarial_framework/main.py cw
