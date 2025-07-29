#!/bin/bash
#SBATCH --job-name=rlearning_orbit
#SBATCH --output=results/%x_%j.o
#SBATCH --error=results/%x_%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=40GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=gengpu
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/users/sbrt882/hyperion/buildrl

source /opt/flight/etc/setup.sh
flight env activate gridware
module load libs/nvidia-cuda/11.2.0/bin
python3 src/do_reinforcement_learning_runs.py
