#!/bin/bash
#FLUX: --job-name=bert_ner
#FLUX: -c=6
#FLUX: --queue=accel
#FLUX: -t=7200
#FLUX: --urgency=16

set -o errexit  # Recommended for easier debugging
module use -a /cluster/projects/nn9851k/software/easybuild/install/modules/all/
module purge   # Recommended for reproducibility
module load NLPL-nlptools/2021.01-gomkl-2019b-Python-3.7.4
module load NLPL-transformers/4.2.2-gomkl-2019b-Python-3.7.4
python3 bert_ner.py --train ${1} --dev ${2} --test ${3} --bert ${4} --name ${5}
