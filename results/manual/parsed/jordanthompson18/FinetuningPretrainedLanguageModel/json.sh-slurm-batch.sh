#!/bin/bash
#SBATCH --account=soc-gpu-np
#SBATCH --output=assignment_1-%j
#SBATCH --mail-user=u1419466@utah.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=40GB
#SBATCH --time=08:00:00
#SBATCH --partition=soc-gpu-np
#SBATCH --constraint=ntasks-per-node=32

source ~/miniconda3/etc/profile.d/conda.sh
conda activate TrainingPLM
pip install jsonlines
python create_json.py
