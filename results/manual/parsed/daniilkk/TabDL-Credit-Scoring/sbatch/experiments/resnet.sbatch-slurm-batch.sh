#!/bin/bash
#SBATCH --job-name=resnet
#SBATCH --output=output/resnet.log
#SBATCH --error=output/resnet-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=1
#SBATCH --time=03:20:00

export PYTHONPATH='$(pwd)'

module purge
module load Python
deactivate
source activate venv
pip install -r requirements.txt
export PYTHONPATH=$(pwd)
for _ in $(seq 1 5); do
    python -u src/train.py --experiment resnet
done
