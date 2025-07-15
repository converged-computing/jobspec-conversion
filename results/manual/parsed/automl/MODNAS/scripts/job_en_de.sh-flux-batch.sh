#!/bin/bash
#FLUX: --job-name=fat-salad-5595
#FLUX: --urgency=16

python search_spaces/hat/train.py --configs=search_spaces/hat/configs/wmt14.en-de/supertransformer/space0.yml
