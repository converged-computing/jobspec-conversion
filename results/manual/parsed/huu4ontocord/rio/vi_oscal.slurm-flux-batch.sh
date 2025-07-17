#!/bin/bash
#FLUX: --job-name=vi_oscar_all
#FLUX: -c=10
#FLUX: --queue=prepost
#FLUX: -t=72000
#FLUX: --urgency=16

export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'

set -x -e
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
module load pytorch-gpu/py3/1.7.0
srun bash -c "time python process.py -hfdataset TurkuNLP/register_oscar,vi -src_lang vi -do_trans 0 -outfile=vi_oscar_all  -do_hf_ner 1 -do_spacy 1 -do_regex 1 -do_kenlm 1 -do_anonymization 1 -num_workers 4"
