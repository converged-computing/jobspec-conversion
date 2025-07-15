#!/bin/bash
#FLUX: --job-name=ornery-lemur-1998
#FLUX: -n=3
#FLUX: -t=259200
#FLUX: --urgency=16

set -e
eval "$(conda shell.bash hook)"
conda activate FACIL
num_tasks=5
nc_first_task=20
num_epochs=200
dataset=imagenet_subset_kaggle
network=resnet18
tag=imagenet_subset_t${num_tasks}s${nc_first_task}
lamb=5
lamb_mc=1.0
beta=5
gamma=1e-3
for wu_nepochs in 0 200; do
  for seed in 0 1 2; do
    ./experiments/lwf.sh 0 ${seed} ${tag} ${dataset} ${num_tasks} ${nc_first_task} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  for seed in 0 1 2; do
    ./experiments/lwf_ta.sh 0 ${seed} ${tag} ${dataset} ${num_tasks} ${nc_first_task} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  for seed in 0 1 2; do
    ./experiments/lwf_mc.sh 0 ${seed} ${tag} ${dataset} ${num_tasks} ${nc_first_task} ${network} ${num_epochs} ${lamb_mc} ${wu_nepochs} &
  done
  wait
  for seed in 0 1 2; do
    ./experiments/lwf_mc_ta.sh 0 ${seed} ${tag} ${dataset} ${num_tasks} ${nc_first_task} ${network} ${num_epochs} ${lamb_mc} ${wu_nepochs} &
  done
  wait
done
