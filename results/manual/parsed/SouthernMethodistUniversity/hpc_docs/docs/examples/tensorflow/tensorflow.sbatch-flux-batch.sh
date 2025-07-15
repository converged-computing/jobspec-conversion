#!/bin/bash
#FLUX: --job-name=muffled-animal-6433
#FLUX: --priority=16

module purge
module load tensorflow
python3 example.py
