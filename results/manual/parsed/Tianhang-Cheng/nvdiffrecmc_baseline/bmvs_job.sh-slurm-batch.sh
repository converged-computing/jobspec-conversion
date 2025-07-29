#!/bin/bash
#SBATCH --job-name=nvdiffrecmc
#SBATCH --output=./logs/man-%a-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --qos=normal

scenes=(
bear
clock
dog
durian
jade
man
sculpture
stone
)
scene="man"
echo "====== Scene: $scene ======"
python train.py --config configs/${scene}.json
