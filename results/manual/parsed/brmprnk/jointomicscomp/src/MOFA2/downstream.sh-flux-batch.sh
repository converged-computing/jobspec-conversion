#!/bin/bash
#FLUX: --job-name=trainJoint
#FLUX: --queue=general --qos=short
#FLUX: -t=7200
#FLUX: --priority=16

ml use /opt/insy/modulefiles;
ml load cuda/11.0;
ml load cudnn/11.0-8.0.3.33;
python src/MOFA2/downstream.py $@;
