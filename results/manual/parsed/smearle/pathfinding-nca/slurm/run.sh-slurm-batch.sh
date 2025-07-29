#!/bin/bash
#SBATCH --job-name=NCA_diameter_128-hid_64-layer_lr-1e-04_10000-data_cutCorners_4
#SBATCH --output=/scratch/zy2043/pathfinding-nca/runs/NCA_diameter_128-hid_64-layer_lr-1e-04_10000-data_cutCorners_4.out
#SBATCH --mail-user=sam.earle@nyu.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

export TUNE_RESULT_DIR='./ray_results/'

export TUNE_RESULT_DIR='./ray_results/'
cd /scratch/zy2043/pathfinding-nca
python -c "from main import *; main_experiment_load_cfg('/scratch/zy2043/pathfinding-nca/slurm/auto_configs/NCA_diameter_128-hid_64-layer_lr-1e-04_10000-data_cutCorners_4.yaml')"
