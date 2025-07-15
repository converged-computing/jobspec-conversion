#!/bin/bash
#FLUX: --job-name=doopy-bicycle-8331
#FLUX: --priority=16

source tensorflow.venv/bin/activate
python pfn_train.py  --doEarlyStopping --latentSize=32 --makeROCs --label="l32" 
