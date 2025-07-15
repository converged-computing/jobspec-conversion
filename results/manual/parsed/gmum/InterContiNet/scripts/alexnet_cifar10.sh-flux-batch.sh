#!/bin/bash
#FLUX: --job-name=interval_cl
#FLUX: -c=10
#FLUX: --priority=16

source .env
trap "kill 0" INT
seed=2001
lr=0.1
for seed in 2001 2002 2003 2004 2005; do
  for lr in 0.2 0.3 0.5; do
    for offline in True; do
      for scenario in INC_TASK; do
        singularity exec --nv $SIF_PATH python3.9 train.py cfg=default_cifar10 cfg.seed=${seed} cfg.scenario=${scenario} cfg.offline=${offline} \
          cfg.learning_rate=$lr tags=["20220606_cifar10_alexnet_offline_sgd_${scenario}_redo_5seeds"]
      done
    done
  done
done
