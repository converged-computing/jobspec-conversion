#!/bin/bash
#SBATCH --job-name=test_symmetric
#SBATCH --output=pong_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1

singularity exec --nv /data/containers/msoe-tensorflow-20.07-tf2-py3.sif python3 -m pip install --user -r requirements.txt
singularity exec --nv /data/containers/msoe-tensorflow-20.07-tf2-py3.sif python3 reinforcement.py
