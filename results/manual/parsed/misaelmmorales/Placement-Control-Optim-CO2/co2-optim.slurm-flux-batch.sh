#!/bin/bash
#FLUX: --job-name=CO2optim
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

pwd
date
module load matlab
matlab hpcRunner
