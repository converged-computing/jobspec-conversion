#!/bin/bash
#SBATCH --job-name=TriagingTuner
#SBATCH --output=triaging_tuner.%j.out
#SBATCH --error=triaging_tuner.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=2-00:00:00
#SBATCH --partition=mpcg.p

module load hpc-env/8.3
module load Python/3.7.4-GCCcore-8.3.0
module load TensorFlow
python nn.py
