#!/bin/bash
#FLUX: --job-name=Vodafone
#FLUX: --queue=small
#FLUX: --urgency=16

module load cuda/9.2
echo $PWD
python3 main.py -m bart
