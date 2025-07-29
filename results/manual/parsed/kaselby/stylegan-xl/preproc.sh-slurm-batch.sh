#!/bin/bash
#SBATCH --job-name=stylegan-xl
#SBATCH --output=logs/slurm-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=50GB
#SBATCH --partition=a40

src=$1
tgt=$2
res=$3
args=${@:4}
python dataset_tool.py --source=$src --dest=$tgt --resolution="${res}x${res}" --transform=center-crop $args
