#!/bin/bash
#SBATCH --job-name=out
#SBATCH --output=out_%j.out
#SBATCH --error=out_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100G
#SBATCH --time=00:01:00
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=1

python __main__.py
