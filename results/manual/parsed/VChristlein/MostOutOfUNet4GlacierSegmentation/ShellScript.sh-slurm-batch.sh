#!/bin/bash
#SBATCH --job-name=[1.0,0.0]Glacier
#SBATCH --output=[1.0,0.0].out
#SBATCH --error=[1.0,0.0].err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=12000

export PATH='/cluster/yr14ofit/miniconda/bin:$PATH'

export PATH=/cluster/yr14ofit/miniconda/bin:$PATH
which python
python main.py --parameter=hyperparameters/hyperparameters_reference.yaml
