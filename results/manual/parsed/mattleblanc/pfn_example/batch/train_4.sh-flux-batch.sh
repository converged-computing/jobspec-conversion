#!/bin/bash
#FLUX: --job-name=scruptious-muffin-4759
#FLUX: --priority=16

source tensorflow.venv/bin/activate
python pfn_train.py  --doEarlyStopping --latentSize=4 --makeROCs --label="l4" 
