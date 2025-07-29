#!/bin/bash
#SBATCH --job-name=mistral-7b-chat-pdf
#SBATCH --account=engin1
#SBATCH --output=/home/asaklani/output.log
#SBATCH --mail-user=asaklani@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=100g
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load python3.10-anaconda
conda activate llm
cd /home/asaklani/llm-recipes/
nvidia-smi
python scripts/train.py --config models/mistral-7b-dolly-5k-rag-split/mistral-7b-dolly-rag.yml
