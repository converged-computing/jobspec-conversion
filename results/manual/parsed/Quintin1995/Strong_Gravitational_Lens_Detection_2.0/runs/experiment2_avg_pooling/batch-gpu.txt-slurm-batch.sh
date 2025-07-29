#!/bin/bash
#SBATCH --job-name=no_avg_pooling_2
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=128000
#SBATCH --time=05:00:00
#SBATCH --partition=gpu
#SBATCH --array=3

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 main.py --run=runs/experiment2_avg_pooling/run${SLURM_ARRAY_TASK_ID}.yaml
