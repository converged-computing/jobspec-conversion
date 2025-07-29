#!/bin/bash
#SBATCH --job-name=eddy_segmenter
#SBATCH --account=users
#SBATCH --output=./output/%j-slurm.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=7-00:00:00
#SBATCH --partition=main

INPUT_FILE=""
source /etc/profile.d/lmod.sh
nvidia-smi
pwd
eval "$(conda shell.bash hook)"
conda activate emirdlp
echo ""
echo "======================================================================================"
env
echo "======================================================================================"
echo ""
echo "======================================================================================"
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
echo "Running Example Job...!"
echo "==============================================================================="
echo "Running Python script..."
python main.py
