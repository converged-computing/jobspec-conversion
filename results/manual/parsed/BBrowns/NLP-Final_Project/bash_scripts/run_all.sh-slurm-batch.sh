#!/bin/bash
#SBATCH --job-name=run_all
#SBATCH --mail-user=j.bruinsma.6@student.rug.nl
#SBATCH --mail-type=BEGIN,END,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=10000
#SBATCH --time=10:00:00
#SBATCH --partition=gpu
#SBATCH --array=1

export WANDB_API_KEY='fe3882bf82f8cd42cf904bc39bf7d2630e31f395'

module purge
module load PyTorch/1.6.0-fosscuda-2019b-Python-3.7.4
pip install --user numpy transformers torch datasets dataloader pandas wandb scikit-learn protobuf
export WANDB_API_KEY=fe3882bf82f8cd42cf904bc39bf7d2630e31f395
cd $HOME/NLP-NLI-explanations/
python3 t5_trainer.py
