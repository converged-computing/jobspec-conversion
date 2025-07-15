#!/bin/bash
#FLUX: --job-name=doopy-arm-5669
#FLUX: -c=10
#FLUX: --priority=16

module load cuda/11.3
python evaluate_guangcui.py --model_path /fs0/home/liqiang/onega_test/hydra/singlerun/2023-04-11/catalyst_oqmd/ --tasks opt --start_from no
