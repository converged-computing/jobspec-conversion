#!/bin/bash
#FLUX: --job-name=muffled-kerfuffle-0442
#FLUX: -c=32
#FLUX: --queue=<partition
#FLUX: -t=432000
#FLUX: --urgency=16

python search_spaces/hat/train.py --configs=search_spaces/hat/configs/wmt14.en-fr/supertransformer/space0.yml
