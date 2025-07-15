#!/bin/bash
#FLUX: --job-name=swampy-rabbit-2929
#FLUX: --priority=16

python search_spaces/hat/train.py --configs=search_spaces/hat/configs/wmt14.en-fr/supertransformer/space0.yml
