#!/bin/bash
#FLUX: --job-name=sentencepiece
#FLUX: -n=8
#FLUX: -t=7800
#FLUX: --priority=16

source ${HOME}/.bashrc
set -o errexit  # Recommended for easier debugging
module purge   # Recommended for reproducibility
module use -a /cluster/projects/nn9851k/software/easybuild/install/modules/all/
module load NLPL-tokenizers/0.10.1-gomkl-2019b-Python-3.7.4
module load NLPL-nlptools/2021.01-gomkl-2019b-Python-3.7.4
echo "Corpus: ${1}"
echo "Output file: ${2}"
python3 spiece_tokenizer.py ${1} ${2}
python3 sent2wordpiece.py ${2}.json -o ${2}.txt
