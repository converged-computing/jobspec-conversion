#!/bin/bash
#FLUX: --job-name=u-chi
#FLUX: -c=3
#FLUX: --queue=Intel
#FLUX: -t=255600
#FLUX: --urgency=16

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
python experiments/experiment.py --do_sweep --env Acrobot-v1 --count 500
echo "Finish Run"
echo "end time is `date`"
