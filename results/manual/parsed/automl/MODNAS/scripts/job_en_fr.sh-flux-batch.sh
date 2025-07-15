#!/bin/bash
#FLUX: --job-name=expressive-fudge-5048
#FLUX: --urgency=16

python search_spaces/hat/train.py --configs=search_spaces/hat/configs/wmt14.en-fr/supertransformer/space0.yml
