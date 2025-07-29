#!/bin/bash
#SBATCH --job-name=my_tensorflow_job
#SBATCH --output=ADL_output.log
#SBATCH --error=ADL_error.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

source activate tensorflow_env
python3 -u ex1_main.py --log-interval 1 --seed 42 --epochs 20000 --model "cvit" 
