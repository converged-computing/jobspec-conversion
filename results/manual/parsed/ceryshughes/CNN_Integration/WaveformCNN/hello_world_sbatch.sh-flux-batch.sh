#!/bin/bash
#FLUX --job-name=misunderstood-ricecake-0500
#FLUX -c=4
#FLUX --queue=gpu
#FLUX -t=86400
#FLUX --urgency=16

module load miniconda/4.11.0
conda run -n cerys python3.8 hello_world.py
