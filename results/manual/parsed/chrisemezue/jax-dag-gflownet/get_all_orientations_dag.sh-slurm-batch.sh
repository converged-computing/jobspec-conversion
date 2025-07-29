#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00

export CUDA_VISIBLE_DEVICES='0'

module load python/3.8
source /home/mila/c/chris.emezue/scratch/py38env/bin/activate
export CUDA_VISIBLE_DEVICES=0
python3 get_all_orientations_dag.py
