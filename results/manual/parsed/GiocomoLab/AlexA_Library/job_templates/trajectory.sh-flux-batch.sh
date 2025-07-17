#!/bin/bash
#FLUX: --job-name=trajectory_predict
#FLUX: -c=4
#FLUX: --queue=giocomo
#FLUX: --urgency=16

ml py-tensorflow/2.1.0_py36
python3 trajectory_prediction.py /oak/stanford/groups/giocomo/attialex /oak/stanford/groups/giocomo/attialex/logs/trajectories/trajectories_1000.npy
