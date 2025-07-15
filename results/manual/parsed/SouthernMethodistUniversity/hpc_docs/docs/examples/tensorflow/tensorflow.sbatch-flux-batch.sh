#!/bin/bash
#FLUX: --job-name=creamy-nalgas-2685
#FLUX: --urgency=16

module purge
module load tensorflow
python3 example.py
