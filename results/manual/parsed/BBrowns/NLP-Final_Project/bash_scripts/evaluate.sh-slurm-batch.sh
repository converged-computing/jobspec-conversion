#!/bin/bash
#SBATCH --job-name=evalate
#SBATCH --mail-user=j.bruinsma.6@student.rug.nl
#SBATCH --mail-type=BEGIN,END,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=10000
#SBATCH --time=10:00:00
#SBATCH --array=1

module purge
module load PyTorch/1.6.0-fosscuda-2019b-Python-3.7.4
pip install --user numpy transformers torch datasets dataloader pandas wandb scikit-learn protobuf
cd $HOME/NLP-NLI-explanations/
python3 evaluate.py
