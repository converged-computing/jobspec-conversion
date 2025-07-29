#!/bin/bash
#FLUX --job-name=crusty-nunchucks-7415
#FLUX --urgency=16

cd /home/um106329/aisafety
source ~/miniconda3/bin/activate
conda activate my-env
python3 compare_weighted.py ${FROM} ${TO} ${MODE} ${FIXRANGE} ${EVALDATASET} ${TRAINDATASET}
