#!/bin/bash
#SBATCH --account=def-hfani
#SBATCH --mail-user=hfani@uwindsor.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=96G
#SBATCH --time=2-00:00:00

python -u main.py -data ../data/raw/dblp/dblp.v12.json -domain dblp -model bnn -filter 1
