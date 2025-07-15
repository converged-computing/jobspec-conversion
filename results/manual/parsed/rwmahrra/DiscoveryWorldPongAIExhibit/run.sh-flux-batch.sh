#!/bin/bash
#FLUX: --job-name=pong_selfplay_batch21
#FLUX: --queue=teaching
#FLUX: --priority=16

singularity run --nv /data/containers/msoe-tensorflow-20.07-tf2-py3.sif python3 reinforcement_selfplay.py
