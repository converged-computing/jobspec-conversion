#!/bin/bash
#FLUX: --job-name=tap-atari-inference
#FLUX: -c=6
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/nvidia'

PATH_TO_ENV=env_TAP
source $PATH_TO_ENV/bin/activate
module load python/3.10
module load gcc/9.3.0
module load opencv/4.7.0
module load mujoco 
module load scipy-stack
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/nikitad/.mujoco/mujoco210/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia
path=latentplan
name=T-1
datasets=(Breakout)
device=cuda
for round in {1..1}; do
  for data in ${datasets[@]}; do
    # python3 $path/scripts/train.py --dataset $data --exp_name $name-$round --tag development --seed $round --device $device
    # python3 $path/scripts/trainprior.py --dataset $data --exp_name $name-$round --device $device
    for i in {1..100}; do
      python3 $path/scripts/plan.py --test_planner beam_prior --dataset $data --exp_name $name-$round --suffix $i --beam_width 64 --n_expand 4 --horizon 24 --device $device
    done
  done
done
for data in ${datasets[@]}; do
  for round in {1..1}; do
    python3 $path/plotting/read_results.py --exp_name $name-$round --dataset $data
  done
done
echo "Done"
