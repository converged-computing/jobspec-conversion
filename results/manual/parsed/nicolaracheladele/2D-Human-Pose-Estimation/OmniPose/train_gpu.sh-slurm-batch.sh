#!/bin/bash
#SBATCH --account=civil-459-2023
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=150G
#SBATCH --time=20:00:00
#SBATCH --qos=dlav
#SBATCH --chdir=/home/ramdass/2D-Human-Pose-Estimation/

./OmniPose/run_train.sh
