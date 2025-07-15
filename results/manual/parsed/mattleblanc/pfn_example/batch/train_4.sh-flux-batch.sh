#!/bin/bash
#FLUX: --job-name=crunchy-mango-7424
#FLUX: --urgency=16

source tensorflow.venv/bin/activate
python pfn_train.py  --doEarlyStopping --latentSize=4 --makeROCs --label="l4" 
