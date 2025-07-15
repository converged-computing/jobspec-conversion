#!/bin/bash
#FLUX: --job-name=sim10e
#FLUX: -c=10
#FLUX: --queue=pascal-deep.p
#FLUX: -t=1209600
#FLUX: --priority=16

module load CUDA/10.0.130
. /home/fatimamh/anaconda3/etc/profile.d/conda.sh
conda activate kis
python /hits/basement/nlp/fatimamh/codes/keep_it_simple/run_keep_it_simple.py -d /hits/basement/nlp/fatimamh/outputs/hipo/exp10/wiki_mono_test-st_bert_base-cos-edge
