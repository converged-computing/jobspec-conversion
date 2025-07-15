#!/bin/bash
#FLUX: --job-name=chunky-despacito-9002
#FLUX: --priority=16

module load miniconda/4.11.0
conda run -n cerys python3.8 hello_world.py
