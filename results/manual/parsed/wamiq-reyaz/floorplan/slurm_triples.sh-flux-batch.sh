#!/bin/bash
#FLUX: --job-name=ornery-leg-8765
#FLUX: -c=6
#FLUX: --queue=batch
#FLUX: -t=21600
#FLUX: --urgency=16

conda activate faclab
which conda
which python
wandb agent wamreyaz/Triplesxy/32q6vpqn
wandb agent wamreyaz/Triples_hw/aqhkplbr
