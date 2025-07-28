#!/bin/bash
#FLUX: --job-name=gpt2-en
#FLUX: -c=4
#FLUX: --queue=pascal-deep.p
#FLUX: -t=1209600
#FLUX: --urgency=16

module load CUDA/10.1.243-GCC-8.3.0
. /home/fatimamh/anaconda3/etc/profile.d/conda.sh
conda activate hugging_face
python /hits/basement/nlp/fatimamh/codes/gpt2_summarization/main.py 
