#!/bin/bash
#FLUX: --job-name=blue-lemur-4783
#FLUX: --urgency=16

source tensorflow.venv/bin/activate
python pfn_train.py  --doEarlyStopping --latentSize=2 --makeROCs --label="l2" 
