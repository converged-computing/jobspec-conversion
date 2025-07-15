#!/bin/bash
#FLUX: --job-name=interval_cl
#FLUX: -c=10
#FLUX: --urgency=16

source .env
trap "kill 0" INT
seed=2001
lr=0.1
for seed in 2001 2002 2003; do
  for temperature in 1; do
    for alpha in 0.5; do
      for scenario in INC_TASK; do
        singularity exec --nv $SIF_PATH python3.9 train.py cfg=default_cifar20x5 cfg.strategy=LWF cfg.seed=${seed} cfg.lwf_alpha=${alpha} \
          cfg.lwf_temperature=${temperature} cfg.scenario=${scenario} \
          tags=["20220531_cifar20x5_alexnet_lwf_${scenario}_3seeds"]
      done
    done
  done
done
