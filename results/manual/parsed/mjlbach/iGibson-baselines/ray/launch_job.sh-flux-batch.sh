#!/bin/bash
#FLUX: --job-name=igibson_rllib_1
#FLUX: -c=45
#FLUX: --queue=viscam
#FLUX: -t=86400
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/'
export PATH='/usr/local/cuda-11.1/bin:$PATH'
export CUDA_HOME='/usr/local/cuda-11.1'

export LD_LIBRARY_PATH=/usr/local/cuda-11.1/lib64
export PATH=/usr/local/cuda-11.1/bin:$PATH
export CUDA_HOME=/usr/local/cuda-11.1
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/libGLEW.so:/usr/lib/x86_64-linux-gnu/libGL.so
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/libEGL_nvidia.so.0:/usr/lib/x86_64-linux-gnu/libEGL.so
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/libOpenGL.so
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/
cd /sailhome/mjlbach/Repositories/iGibson
source ~/.virtualenvs/igibsonvr/bin/activate
python /sailhome/mjlbach/Repositories/iGibson-baselines/ray/shared_head.py --local_dir /viscam/u/mjlbach/igibson_training_runs_lidar_share_head --config /sailhome/mjlbach/Repositories/iGibson-baselines/configs/turtlebot_point_nav.yaml
