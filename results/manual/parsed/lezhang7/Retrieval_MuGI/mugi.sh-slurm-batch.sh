#!/bin/bash
#FLUX: --job-name=mugi_pipeline
#FLUX: -c=4
#FLUX: --queue=long
#FLUX: -t=14400
#FLUX: --urgency=16

module load miniconda/3
conda init
conda activate openflamingo
for irmode in mugisparse
do
    python mugi.py --llm gpt --irmode $irmode
done
