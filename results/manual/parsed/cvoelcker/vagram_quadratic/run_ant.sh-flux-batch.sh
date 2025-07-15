#!/bin/bash
#FLUX: --job-name=ant-vagram
#FLUX: -t=57600
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/h/voelcker/Code/project_codebases/vagram_quadratic'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/nvidia'

source ~/.bashrc
module load cuda-11.3
conda deactivate
source ~/jax_gpu/bin/activate
export PYTHONPATH=$PYTHONPATH:/h/voelcker/Code/project_codebases/vagram_quadratic
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/nvidia/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/h/voelcker/.mujoco/mujoco210/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia
cd ~/Code/project_codebases/vagram_quadratic
echo $1
echo $2
python examples/train.py --env_name Ant-v3 --model_loss_fn $1 --max_steps 1500000 --seed $2 --model_hidden_size 128
