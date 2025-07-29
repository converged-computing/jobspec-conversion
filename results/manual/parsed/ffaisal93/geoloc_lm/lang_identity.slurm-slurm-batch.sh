#!/bin/bash
#SBATCH --job-name=python-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=96G
#SBATCH --time=1-00:10:55
#SBATCH --partition=normal

source vnv/geo_vnv/bin/activate
pip install spacy
pip install spacy-langdetect
python -m spacy download en
python -m spacy download bn
python -m spacy download ru
python -m spacy download zh
python -m spacy download kr
python -m spacy download fr
python -m spacy download ar
