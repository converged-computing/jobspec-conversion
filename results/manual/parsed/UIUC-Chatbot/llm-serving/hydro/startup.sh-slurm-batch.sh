#!/bin/bash
#SBATCH --job-name=flask_server
#SBATCH --output=flask_server.out
#SBATCH --error=flask_server.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=0
#SBATCH --time=01:00:00
#SBATCH --exclusive

module load cuda/12.2.1
module load python/3.9.13
VENV_NAME="env"
if [ ! -d "$VENV_NAME" ]
then
    # The virtual environment doesn't exist, create it
    python3.9 -m venv $VENV_NAME
fi
source $VENV_NAME/bin/activate
pip install -r requirements.txt
python server.py
