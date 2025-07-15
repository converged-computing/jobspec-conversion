#!/bin/bash
#FLUX: --job-name=crunchy-butter-9072
#FLUX: --priority=16

python search_spaces/hat/train.py --configs=search_spaces/hat/configs/wmt14.en-de/supertransformer/space0.yml
