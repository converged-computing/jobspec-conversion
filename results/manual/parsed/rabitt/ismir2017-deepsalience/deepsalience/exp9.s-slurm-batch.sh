#!/bin/bash
#SBATCH --job-name=d9
#SBATCH --output=slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=50GB
#SBATCH --time=14:00:00
#SBATCH --partition=gpu

module purge
module load cuda/8.0.44
module load cudnn/8.0v5.1
module load ffmpeg/intel/3.2.2
source ~/.bashrc
unset XDG_RUNTIME_DIR
cd ~/repos/multif0/deepsalience
python multif0_exper9.py
