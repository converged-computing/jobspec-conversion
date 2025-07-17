#!/bin/bash
#FLUX: --job-name=intcqa_bert_quick
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: -t=259200
#FLUX: --urgency=16

export OMP_NUM_THREADS='24'

module load lang/python/anaconda/pytorch
cd /user/home/es1595/tacl2020-interactive-ranking
export OMP_NUM_THREADS=24
python -u stage1_coala.py GPPLHH 0 cqa_bert_imp_gpplhh_4 "[imp]" . 4 4 BERT
