#!/bin/bash
#FLUX: --job-name=cartpole_se_master
#FLUX: --priority=16

export HTTP_PROXY='http://tfproxy.informatik.uni-freiburg.de:8080'
export HTTPS_PROXY='https://tfproxy.informatik.uni-freiburg.de:8080'
export http_proxy='http://tfproxy.informatik.uni-freiburg.de:8080'
export https_proxy='https://tfproxy.informatik.uni-freiburg.de:8080'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/ferreira/.mujoco/mjpro150/bin'
export PYTHONPATH='$PYTHONPATH:.'

export HTTP_PROXY=http://tfproxy.informatik.uni-freiburg.de:8080
export HTTPS_PROXY=https://tfproxy.informatik.uni-freiburg.de:8080
export http_proxy=http://tfproxy.informatik.uni-freiburg.de:8080
export https_proxy=https://tfproxy.informatik.uni-freiburg.de:8080
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH
echo "source activate"
source ~/.miniconda/bin/activate gtn
echo "run script"
export PYTHONPATH=$PYTHONPATH:.
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ferreira/.mujoco/mjpro150/bin
bohb_id=$(($SLURM_ARRAY_TASK_ID+20000))
cd experiments
python3 -u GTNC_evaluate_cartpole.py $bohb_id 8
echo "done"
