#!/bin/bash
#FLUX: --job-name=ycb_demo
#FLUX: -t=7200
#FLUX: --urgency=16

cd /scratch/$USER/YCB_demo
module purge
module load python/intel/3.8.6
pip install -r requirements.txt
./experiments/scripts/ycb_video_test.sh
