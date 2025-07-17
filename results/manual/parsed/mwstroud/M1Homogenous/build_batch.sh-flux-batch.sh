#!/bin/bash
#FLUX: --job-name=MC_sim
#FLUX: -t=172800
#FLUX: --urgency=16

python build_network.py #srun
