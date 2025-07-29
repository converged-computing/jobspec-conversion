#!/bin/bash
#FLUX: --job-name=save_fps_9
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

ml cuda/10.0.130 python/2.7.13 py-scipystack/1.0_py27 py-tensorflow/1.12.0_py27 py-h5py
srun python save_all_fps.py --gres
