#!/bin/bash
#SBATCH --job-name=hamnet
#SBATCH --output=outputs/qm9-0808-all.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00
#SBATCH --partition=GPU
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

python model_test.py
