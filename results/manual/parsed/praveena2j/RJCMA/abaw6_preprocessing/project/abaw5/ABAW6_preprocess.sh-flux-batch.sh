#!/bin/bash
#FLUX: --job-name=ABAW6_preprocess
#FLUX: -t=1296000
#FLUX: --priority=16

export PATH='/misc/scratch11/anaconda3/bin:$PATH'

export PATH="/misc/scratch11/anaconda3/bin:$PATH"
source activate pre
scripts_dir=`pwd`
MatlabFE=`pwd`
mdl=senet18e17
lf=ocsoftmax
atype=LA
python3 main.py
wait
echo "DONE"
