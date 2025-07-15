#!/bin/bash
#FLUX: --job-name=scruptious-bits-4979
#FLUX: --urgency=16

source tensorflow.venv/bin/activate
python pfn_train.py  --doEarlyStopping --latentSize=32 --makeROCs --label="l32" 
