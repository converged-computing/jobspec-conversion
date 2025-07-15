#!/bin/bash
#FLUX: --job-name=expressive-cattywampus-9829
#FLUX: -t=86400
#FLUX: --priority=16

module add cuda/10.0
module add cudnn/7-cuda-10.0
python 2.py 1 0 &
python 2.py 2 1 &
python 2.py 3 1 &
python 2.py 0 0
