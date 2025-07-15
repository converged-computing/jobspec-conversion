#!/bin/bash
#FLUX: --job-name=u-chi
#FLUX: -c=3
#FLUX: --queue=DGXA100
#FLUX: -t=255600
#FLUX: --priority=16

export CPATH='$CPATH:$CONDA_PREFIX/include'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib'
export MUJOCO_GL='glfw'

echo "using scavenger"
eval "$(conda shell.bash hook)"
conda activate /home/jacob.adamczyk001/miniconda3/envs/oblenv
export CPATH=$CPATH:$CONDA_PREFIX/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib
export MUJOCO_GL="glfw"
echo "Start Run"
echo `date`
python experiments/local_finetuned_runs.py --env PongNoFrameskip-v4 -a u -d cuda
echo "Finish Run"
echo "end time is `date`"
