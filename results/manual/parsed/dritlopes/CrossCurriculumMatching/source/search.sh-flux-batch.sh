#!/bin/bash
#FLUX: --job-name=loopy-animal-2028
#FLUX: --urgency=16

module load 2020
module load Anaconda3/2020.02
module load Python/3.8.2-GCCcore-9.3.0
python --version
source /sw/arch/Debian10/EB_production/2020/software/Anaconda3/2020.02/etc/profile.d/conda.sh
conda activate venv2020
conda install -c conda-forge sentence-transformers
conda install scikit-learn
conda install pandas
conda install pytorch
conda install nltk
conda install matplotlib
conda install seaborn
conda install openpyxl
conda install -c conda-forge fasttext
conda install scipy
conda install -c conda-forge lightgbm
python $HOME/query_matching/query_matching/source/main.py $HOME/query_matching/query_matching/data $HOME/query_matching/query_matching/models $HOME/query_matching/query_matching/eval $HOME/query_matching/query_matching/results
