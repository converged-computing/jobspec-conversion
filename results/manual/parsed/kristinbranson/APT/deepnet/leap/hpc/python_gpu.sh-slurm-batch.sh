#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=128000
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1,ntasks-per-socket=1

echo "args: ${@:1}"
python ${@:1}
