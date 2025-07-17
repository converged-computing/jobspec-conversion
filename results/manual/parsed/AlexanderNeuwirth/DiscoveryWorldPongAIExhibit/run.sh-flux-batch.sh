#!/bin/bash
#FLUX: --job-name=test_symmetric
#FLUX: --queue=teaching
#FLUX: --urgency=16

singularity exec --nv /data/containers/msoe-tensorflow-20.07-tf2-py3.sif python3 -m pip install --user -r requirements.txt
singularity exec --nv /data/containers/msoe-tensorflow-20.07-tf2-py3.sif python3 reinforcement.py
