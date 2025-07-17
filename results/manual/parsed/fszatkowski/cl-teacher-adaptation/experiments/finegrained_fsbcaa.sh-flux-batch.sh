#!/bin/bash
#FLUX: --job-name=dinosaur-animal-2666
#FLUX: -n=3
#FLUX: -t=259200
#FLUX: --urgency=16

set -e
eval "$(conda shell.bash hook)"
conda activate FACIL
num_epochs=200
network=resnet18
dataset='flowers scenes birds cars aircrafts actions flowers scenes birds cars aircrafts actions flowers scenes birds cars aircrafts actions flowers scenes birds cars aircrafts actions'
num_classes_per_dataset=5
tag=finegrained_fsbcaa_24x${num_classes_per_dataset}
for wu_nepochs in 0 200; do
  lamb=10
  for seed in 0 1 2; do
    ./experiments/lwf_fg.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  for seed in 0 1 2; do
    ./experiments/lwf_fg_ta.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  lamb=1
  for seed in 0 1 2; do
    ./experiments/lwf_tw_fg.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  for seed in 0 1 2; do
    ./experiments/lwf_tw_fg_ta.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
done
dataset='flowers scenes birds cars aircrafts actions flowers scenes birds cars aircrafts actions'
num_classes_per_dataset=10
tag=finegrained_fsbcaa_12x${num_classes_per_dataset}
for wu_nepochs in 0 200; do
  lamb=10
  for seed in 0 1 2; do
    ./experiments/lwf_fg.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  for seed in 0 1 2; do
    ./experiments/lwf_fg_ta.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  lamb=1
  for seed in 0 1 2; do
    ./experiments/lwf_tw_fg.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  for seed in 0 1 2; do
    ./experiments/lwf_tw_fg_ta.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
done
dataset='flowers scenes birds cars aircrafts actions'
num_classes_per_dataset=20
tag=finegrained_fsbcaa_6x${num_classes_per_dataset}
for wu_nepochs in 0 200; do
  lamb=10
  for seed in 0 1 2; do
    ./experiments/lwf_fg.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  for seed in 0 1 2; do
    ./experiments/lwf_fg_ta.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  lamb=1
  for seed in 0 1 2; do
    ./experiments/lwf_tw_fg.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
  for seed in 0 1 2; do
    ./experiments/lwf_tw_fg_ta.sh 0 ${seed} ${tag} "${dataset}" ${num_classes_per_dataset} ${network} ${num_epochs} ${lamb} ${wu_nepochs} &
  done
  wait
done
