#!/bin/bash
#FLUX: --job-name=getdata
#FLUX: -c=40
#FLUX: -t=32400
#FLUX: --priority=16

module purge
module load anaconda-py3/2019.03
conda activate retrocode
set -x
nvidia-smi
bash dataset/nl/seq2seq/en2fr/prepare-wmt14en2fr.sh
bash dataset/nl/seq2seq/en2de/prepare-wmt14en2de.sh
bash dataset/nl/lm/en2fr/prepare-wmt14en2fr.sh
bash dataset/nl/lm/en2de/prepare-wmt14en2de.sh
