#!/bin/bash
#SBATCH --job-name=trajectory_predict
#SBATCH --output=/scratch/users/attialex/slurm.%N.%j.out
#SBATCH --error=/scratch/users/attialex/slurm.%N.%j.err
#SBATCH --mail-user=attialex@stanford.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=12G
#SBATCH --constraint=ntasks-per-node=1

ml py-tensorflow/2.1.0_py36
python3 trajectory_prediction.py /oak/stanford/groups/giocomo/attialex /oak/stanford/groups/giocomo/attialex/logs/trajectories/trajectories_1000.npy
