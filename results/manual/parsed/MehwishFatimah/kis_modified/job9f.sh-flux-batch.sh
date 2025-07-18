#!/bin/bash
#FLUX: --job-name=sim9f
#FLUX: -c=10
#FLUX: --queue=pascal-deep.p
#FLUX: -t=1209600
#FLUX: --urgency=16

module load CUDA/10.0.130
. /home/fatimamh/anaconda3/etc/profile.d/conda.sh
conda activate kis
python /hits/basement/nlp/fatimamh/codes/keep_it_simple/run_keep_it_simple.py -d /hits/basement/nlp/fatimamh/outputs/hipo/exp09/wiki_mono_test-rand_20-cos-undirected-add_f=0.0_b=1.0_s=1.0
