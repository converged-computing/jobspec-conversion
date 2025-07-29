#!/bin/bash
#SBATCH --job-name=save_fps_9
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00

ml cuda/10.0.130 python/2.7.13 py-scipystack/1.0_py27 py-tensorflow/1.12.0_py27 py-h5py
srun python save_all_fps.py --gres
