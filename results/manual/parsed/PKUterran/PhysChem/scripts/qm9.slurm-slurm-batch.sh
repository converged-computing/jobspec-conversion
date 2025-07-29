#!/bin/bash
#SBATCH --job-name=QM9
#SBATCH --output=outputs/qm9-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=5-00:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

python qm9.py
