#!/bin/bash
#FLUX: --job-name=loopy-noodle-3618
#FLUX: -c=10
#FLUX: --queue=batch
#FLUX: -t=36000
#FLUX: --priority=16

conda activate faclab
wandb agent wamreyaz/furniture_nodes_suppl/96njf9mv
