#!/bin/bash
#SBATCH --account=sbel
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:gtx1080:1
#SBATCH --time=10-00:00:00
#SBATCH --qos=sbel_owner
#SBATCH --nodelist=euler07

/srv/home/whu59/research/chrono_related_package/blender-2.91.0-linux64/blender --background --python ./blender.py
