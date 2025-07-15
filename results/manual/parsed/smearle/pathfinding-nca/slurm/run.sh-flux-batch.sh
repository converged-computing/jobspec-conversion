#!/bin/bash
#FLUX: --job-name=NCA_diameter_128-hid_64-layer_lr-1e-04_10000-data_cutCorners_4
#FLUX: -t=7200
#FLUX: --priority=16

export TUNE_RESULT_DIR='./ray_results/'

export TUNE_RESULT_DIR='./ray_results/'
cd /scratch/zy2043/pathfinding-nca
python -c "from main import *; main_experiment_load_cfg('/scratch/zy2043/pathfinding-nca/slurm/auto_configs/NCA_diameter_128-hid_64-layer_lr-1e-04_10000-data_cutCorners_4.yaml')"
