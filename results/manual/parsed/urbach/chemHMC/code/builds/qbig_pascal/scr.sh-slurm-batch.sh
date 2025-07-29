#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:pascal:1
#SBATCH --mem=15GB
#SBATCH --time=04:00:00
#SBATCH --partition=batch
#SBATCH --qos=devel
#SBATCH --constraint=ntasks-per-node=1

source load_modules_qbig_pascal.sh
