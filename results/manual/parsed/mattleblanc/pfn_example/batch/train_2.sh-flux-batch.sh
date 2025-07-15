#!/bin/bash
#FLUX: --job-name=rainbow-salad-1065
#FLUX: --priority=16

source tensorflow.venv/bin/activate
python pfn_train.py  --doEarlyStopping --latentSize=2 --makeROCs --label="l2" 
