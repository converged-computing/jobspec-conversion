#!/bin/bash
#FLUX: --job-name=outstanding-general-0957
#FLUX: -c=6
#FLUX: --queue=batch
#FLUX: -t=21600
#FLUX: --priority=16

conda activate faclab
which conda
which python
python train_walls.py --tuples 3\
		      --notes 'demo' \
		      --lr 0.00001
