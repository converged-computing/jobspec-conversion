#!/bin/bash
#SBATCH --job-name=road_map_01
#SBATCH --mail-user=mh5275@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:p40:1
#SBATCH --mem=16GB
#SBATCH --time=1-00:00:00

. ~/.bashrc
module load anaconda3/5.3.1
conda activate pytorch
conda install -n pytorch nb_conda_kernels
python train_road_map.py
