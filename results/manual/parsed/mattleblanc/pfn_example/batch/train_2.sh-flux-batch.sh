#!/bin/bash
#FLUX: --job-name=PFN-l2
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

source tensorflow.venv/bin/activate
python pfn_train.py  --doEarlyStopping --latentSize=2 --makeROCs --label="l2" 
