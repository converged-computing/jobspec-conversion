#!/bin/bash
#SBATCH --job-name=ACE
#SBATCH --account=ec30
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=1
#SBATCH --mem=8G
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

set -o errexit
set -o nounset
module purge
module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module load nlpl-pytorch/1.7.1-foss-2019b-cuda-11.1.1-Python-3.7.4
module load nlpl-transformers/4.14.1-foss-2019b-Python-3.7.4
module load nlpl-nlptools/2021.01-foss-2019b-Python-3.7.4
module load nlpl-scipy-ecosystem/2021.01-foss-2019b-Python-3.7.4
module load sentencepiece/0.1.96-foss-2019b-Python-3.7.4
module load nlpl-nltk/3.5-foss-2019b-Python-3.7.4
module load nlpl-wandb/0.12.6-foss-2019b-Python-3.7.4
TRANSFORMERS_OFFLINE=1 python3 train.py --log_wandb --config "$1" --name "$2"
