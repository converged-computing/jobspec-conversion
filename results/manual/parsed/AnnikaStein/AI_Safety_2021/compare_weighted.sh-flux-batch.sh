#!/bin/bash
#FLUX: --job-name=delicious-soup-8157
#FLUX: --priority=16

cd /home/um106329/aisafety
source ~/miniconda3/bin/activate
conda activate my-env
python3 compare_weighted.py ${FROM} ${TO} ${MODE} ${FIXRANGE} ${EVALDATASET} ${TRAINDATASET}
