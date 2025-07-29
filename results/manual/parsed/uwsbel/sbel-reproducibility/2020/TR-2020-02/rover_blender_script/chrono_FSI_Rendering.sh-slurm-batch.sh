#!/bin/bash
#SBATCH --account=sbel
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx2080ti:1
#SBATCH --time=10-00:00:00
#SBATCH --partition=sbel
#SBATCH --qos=sbel_owner

/srv/home/whu59/research/chrono_related_package/blender-2.91.0-linux64/blender --background --python ./bld_test.py
