#!/bin/bash
#FLUX: --job-name=arid-carrot-6497
#FLUX: -c=32
#FLUX: --queue=<partition
#FLUX: -t=432000
#FLUX: --urgency=16

python search_spaces/hat/train.py --configs=search_spaces/hat/configs/wmt14.en-de/supertransformer/space0.yml
