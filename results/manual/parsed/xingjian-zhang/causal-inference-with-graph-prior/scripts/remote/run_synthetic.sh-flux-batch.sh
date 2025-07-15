#!/bin/bash
#FLUX: --job-name=syn_causal_graph
#FLUX: --queue=standard
#FLUX: -t=1200
#FLUX: --priority=16

PYTHON=/home/jimmyzxj/miniconda3/envs/causal_graph_prior/bin/python3
RANDOM_SEED=${SLURM_ARRAY_TASK_ID}
PROJECT_DIR=/home/jimmyzxj/Research/causal_graph_prior
cd $PROJECT_DIR
make all PYTHON=$PYTHON RANDOM_SEED=$RANDOM_SEED DATASET_CONFIG=synthetic_ctrl.yaml
make all PYTHON=$PYTHON RANDOM_SEED=$RANDOM_SEED DATASET_CONFIG=synthetic_no_ctrl.yaml
