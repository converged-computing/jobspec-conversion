#!/bin/bash
#FLUX: --job-name=an-cockrell
#FLUX: -t=648000
#FLUX: --urgency=16

pwd; hostname; date
module load python3
cd /home/adam.knapp/blue_rlaubenbacher/adam.knapp/data-assimilation/kalman/an-cockrell-abm/an-cockrell
python3 an-cockrell-runner.py
date
