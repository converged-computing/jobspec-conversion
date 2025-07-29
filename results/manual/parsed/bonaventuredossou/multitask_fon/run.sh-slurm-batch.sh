#!/bin/bash
#SBATCH --job-name=multitaskfon
#SBATCH --output=/home/mila/b/bonaventure.dossou/multitask_fon/slurmoutput.txt
#SBATCH --error=/home/mila/b/bonaventure.dossou/multitask_fon/slurmerror.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx8000:8
#SBATCH --mem=128G
#SBATCH --time=7-00:00:00

module load python/3.9 cuda/10.2/cudnn/7.6
source /home/mila/b/bonaventure.dossou/env/bin/activate
cd /home/mila/b/bonaventure.dossou/multitask_fon
pip install -r requirements.txt
cd code
python run_train.py
