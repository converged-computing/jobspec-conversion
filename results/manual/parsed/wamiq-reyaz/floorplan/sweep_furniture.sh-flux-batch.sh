#!/bin/bash
#FLUX: --job-name=furn_nodes
#FLUX: -c=10
#FLUX: --queue=batch
#FLUX: -t=36000
#FLUX: --urgency=16

conda activate faclab
wandb agent wamreyaz/furniture_nodes_suppl/96njf9mv
