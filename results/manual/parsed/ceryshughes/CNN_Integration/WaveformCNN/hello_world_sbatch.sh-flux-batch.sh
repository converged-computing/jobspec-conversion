#!/bin/bash
#FLUX: --job-name=nerdy-puppy-2899
#FLUX: --urgency=16

module load miniconda/4.11.0
conda run -n cerys python3.8 hello_world.py
