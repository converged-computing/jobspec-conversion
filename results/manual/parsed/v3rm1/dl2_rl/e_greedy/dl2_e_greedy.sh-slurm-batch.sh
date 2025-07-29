#!/bin/bash
#SBATCH --job-name=dl2_e_greedy_pong
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=72000
#SBATCH --time=2-22:00:00
#SBATCH --partition=gpu

module load Python/3.6.4-foss-2018a
module load CUDA/9.1.85
module load Boost/1.66.0-foss-2018a-Python-3.6.4
module load TensorFlow/1.12.0-fosscuda-2018a-Python-3.6.4
python ./pong.py
mv *.out slurm/
