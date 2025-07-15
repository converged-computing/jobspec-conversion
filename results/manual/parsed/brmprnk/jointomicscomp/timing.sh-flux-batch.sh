#!/bin/bash
#FLUX: --job-name=timer
#FLUX: -c=2
#FLUX: --queue=general --qos=medium
#FLUX: -t=28799
#FLUX: --priority=16

ml use /opt/insy/modulefiles;
ml load cuda/11.0;
ml load cudnn/11.0-8.0.3.33;
python src/util/timer.py;
