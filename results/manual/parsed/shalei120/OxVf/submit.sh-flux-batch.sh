#!/bin/bash
#FLUX: --job-name=Vodafone
#FLUX: --queue=small
#FLUX: --priority=16

module load cuda/9.2
echo $PWD
python3 main.py 
